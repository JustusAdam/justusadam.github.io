#import "../lib/template.typ": template
#show: template

= How to create downloadable executables for your project with GitHub actions

_2020-08-27_

With the release of
#link("https://docs.github.com/en/actions")[GitHub Actions] we have
gained an incredibly powerful tool when it comes to testing and
publishing software hosted on GitHub. Actions lets you essentially
perform arbitrary computing tasks whenever certain events in your
repository are triggered. While platforms like Circle-CI or Travis have
offered similar capabilities for a while, Actions make some of those
tasks significantly more convenient due to how deeply it is integrated
with GitHub.

What I want to show you in this post is how you can provide downloadable
compiled binaries and tarballs for users of your projects using just a
few lines of Actions configuration. Having prebuilt binaries like this
makes it significantly easier for new users to check out and start using
your project, especially those less familiar with the language and
tooling you use.

In this post I will be describing a project written in
#link("https://haskell.org")[Haskell] and built using
#link("https://docs.haskellstack.org")[stack]. However except for the
build commands none of the configuration is unique to this toolchain and
you should be able to easily adapt it to your own build method.

I've created a test repo to tinker with this stuff which you can find
#link("https://github.com/JustusAdam/create-haskell-binaries-with-actions")[here].
There you can find the configuration I describe below, as well as see
the uploaded assets on the releases page.

If you just want to see the configuration I use and figure the rest out
for yourself, take a look at the section
#link(<configuration>)[Configuration]. #link(<explanation>)[After that]
I'll explain in more detail the individual steps taken in the
configuration and I'll close with some #link(<caveats>)[Caveats] that
apply to this method.

The next section is about my motivation for getting involved with this
and writing this post. If you are only here for the technical stuff you
can safely #link(<configuration>)[skip it].

== Motivation
<motivation>
I recently found myself wanting to check out a project called
#link("https://github.com/jgm/gitit")[gitit] which is essentially a
small server that serves a wiki. All the wiki really is is a git
repository of files with support for several formats, such as markdown.
The server lets you view, create and edit the files in the browser and
persists your changes by committing. Its a nice, simple piece of
software, especially because the stored data can easily be handled
outside of the server, making it easy to migrate or interact with from
an editor.

What I found rather annoying is that, given the features, this piece of
software should be a simple, small binary with perhaps a few static
assets. And it is. However the only method available for acquisition is
building from source. Now 💚 Haskell, #strong[but] it is notorious for
its slow build times. To make matters worse, `gitit`, in order to
support multiple file formats, depends the library version of a software
called #link("https://pandoc.org")[`pandoc`], which is a large,
multi-format document rendering and conversion software. This means to
build `gitit` the large `pandoc` software has to be built, pulling in
and building all of its many dependencies. If I remember correctly a
total of around 120 Haskell libraries were downloaded and built, which
took over 30 minutes on a quad core machine, just to make this simple,
tiny 40mb binary. Not to mention that someone who doesn't have Haskell
installed would also have to download the build tools `ghc`, `stack`,
`cabal` etc.

Given how scary and involved this process is and how obscure Haskell as
a language is I feel that this simple software would be significantly
more accessible to people if it provided prebuilt binaries that one
would just have to download and run. Takes but a few seconds and avoids
having to explain the build process. And since the project is already
using GitHub Actions as CI, adding another config to build assets on
release seems like a pretty straightforward addition.

Back in the day I used to so similar things on Travis, building and
uploading binaries. Back then it required you to create a custom API key
for interacting with the GitHub releases and storing that in Travis as
well as properly talking to the GitHub API to upload stuff. It may be a
bit much to ask of authors to set up travis and the keys etc, etc. But
since Actions needs none of that I feel it's low-effort enough for
virtually anyone to just start using it. Hence this call to … Actions 😜

If you're interested, my PR with the changes to the gitit workflows can
be found #link("https://github.com/jgm/gitit/pull/662")[here].

== Configuration
<configuration>
```yaml
name: Create Assets

on:
  release:
    types: [published]

jobs:
  build:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest]

    steps:
    - uses: actions/checkout@v2

    - name: Cache programs and libraries
      uses: actions/cache@v2
      env:
        cache-name: cache-tools-and-libraries
      with:
        path: ~/.stack
        key: ${{ runner.os }}-ca-${{ env.cache-name }}-${{ hashFiles('**/stack.yaml.lock') }}
        restore-keys: |
          ${{ runner.os }}-ca-${{ env.cache-name }}-
          ${{ runner.os }}-ca-
          ${{ runner.os }}-

    - name: Build the project
      run: stack build

    - name: Tar and strip the binary
      run: |
        export PROGRAM=chbwa
        cp `stack exec -- which $PROGRAM` $PROGRAM
        tar -cavf program.tar.gz $PROGRAM

    - name: Upload assets
      id: upload-release-asset
      uses: actions/upload-release-asset@v1
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        upload_url: ${{ github.event.release.upload_url }}
        asset_path: ./program.tar.gz
        asset_name: program-${{ runner.os }}.tar.gz
        asset_content_type: application/tar.gz
```

== Explanation
<explanation>
=== Header and build config
<header-and-build-config>
```yaml
name: Create Assets

on:
  release:
    types: [published]

jobs:
  build:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest]
```

Standard header. We name the workflow and configure the trigger using
the `on` clause. While you can choose several triggers, you can only
upload assets for releases. If another event were to trigger the
workflow the upload url used later in the configuration would be
missing.

We configure to run on all platforms available to github#footnote[Not
quite true, we only run on their latest versions. You can run on more
versions, but I haven't yet discovered how to get the version identifier
during the build to include in the asset name.] using the
#link("https://docs.github.com/en/actions/configuring-and-managing-workflows/configuring-a-workflow#configuring-a-build-matrix")[`matrix`].
#strong[Important:] GitHub also offers builds on Windows, but I haven't
yet translated the `steps` to the shell used on windows. I know how to
include platform-dependent steps in the config, but I'm not familiar
enough with the Windows shell to translate the commands. If you know
what these commands would look like on Windows,
#link("mailto:dev@justus.science")[let me know].

=== Checkout
<checkout>
```yaml
steps:
- uses: actions/checkout@v2
```

The steps list the various commands we'd like to run. They can either
call on actions (`uses` key) or sun shell commands (`run` key). This
action here
#link("https://docs.github.com/en/actions/configuring-and-managing-workflows/configuring-a-workflow#using-the-checkout-action")[checks out the repo].

=== #link("https://docs.github.com/en/actions/configuring-and-managing-workflows/caching-dependencies-to-speed-up-workflows")[Caching]
<caching>
```yaml
- name: Cache programs and libraries
  uses: actions/cache@v2
  env:
    cache-name: cache-tools-and-libraries
  with:
    path: ~/.stack
    key: ${{ runner.os }}-ca-${{ env.cache-name }}-${{ hashFiles('**/stack.yaml.lock') }}
    restore-keys: |
      ${{ runner.os }}-ca-${{ env.cache-name }}-
      ${{ runner.os }}-ca-
      ${{ runner.os }}-
```

I've left this in here, but I'm sad to say it doesn't work for me. For
some reason the key lookup always fails. If anyone has an idea why
#link("mailto:dev@justus.science")[let me know].

=== Building
<building>
```yaml
- name: Build the project
  run: stack build

- name: Tar and strip the binary
  run: |
    export PROGRAM=chbwa
    cp `stack exec -- which $PROGRAM` $PROGRAM
    tar -cavf program.tar.gz $PROGRAM
```

Build the project the usual way.

If you have additional assets you need to distribute with your
executable I recommend packaging it as a archive here. This reduces the
download times.

=== Dealing with `data-files` (Haskell specific)
<dealing-with-data-files-haskell-specific>
Some Haskell libraries and executables rely on additional `data-files`
and the `Paths_package_name` module,
#link("https://cabal.readthedocs.io/en/3.4/cabal-package.html#accessing-data-files-from-package-code")[managed by cabal].
#strong[If you get an error that a certain file could not be opened when
running the binary you uploaded as a asset, this is likely the reason.]
Especially if the path is something like
`/home/runner/.stack/snapshots/<a long hash value>/package-1.0.5/...`.

There are two components to fixing this error.

+ You must identify the files to include and
+ Overwrite the paths cabal has baked into the program

I describe how to do both of those shortly, but you may also like to
look at
#link("https://gist.github.com/JustusAdam/5904249d909e975edb612e5eea581ba1")[this gist]
which is a Haskell script that does both and copies the files to a
directory (`vendor-data/package-name`).

==== 1. Finding assets
<finding-assets>
If the missing assets are from your project itself you can skip this
step and move on.

When stack or cabal was building your project it will have stored asset
files of all libraries and `ghc-pkg` knows where. To find the data
directory of a library (say `filestore`) use the command
`ghc-pkg field filestore data-dir`. If you are using stack you should
prepend `stack exec --` before this command to make sure you query the
correct package database. This returns a string of the form
`"data-dir: /home/user/...\n"`. So you need to strip off the
`"data-dir: "` prefix, as well as the trailing `\n`.

==== 1. Overwriting cabal paths
<overwriting-cabal-paths>
Libraries that use the `data-dir` functionality interact with is
typically using the `Paths_<package name>` generated module. You can
overwrite any paths set in this module using environment variables. For
instance, if I wanted to set the `data-file` path for the `filestore`
package to `"foo/bar"`, I have to set the variable
`filestore_datadir=foo/bar`. This is documented
#link("https://cabal.readthedocs.io/en/3.4/cabal-package.html#accessing-data-files-from-package-code")[here]
in the cabal manual.

My solution for doing this automatically ist to not directly call the
compiled binary, but instead providing a shell script that sets these
variables before calling the actual program, forwarding any arguments.
You can see an example of such a script
#link("https://github.com/JustusAdam/gitit/blob/4e5e522c673411eba4c02ec33dcf5528cdcb4312/unix-proxy.sh")[here].

=== Upload
<upload>
```yaml
- name: Upload assets
  id: upload-release-asset
  uses: actions/upload-release-asset@v1
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  with:
    upload_url: ${{ github.event.release.upload_url }}
    asset_path: ./program.tar.gz
    asset_name: program-${{ runner.os }}.tar.gz
    asset_content_type: application/tar.gz
```

This is where the convenience of Actions really comes in. We can use the
predefined
#link("https://github.com/actions/upload-release-asset")[`upload-release-asset`]
action which will deal with talking to the the GitHub API for us. In
addition we have access to the `secrets.GITHUB_TOKEN` which is used to
authenticate the upload request. We do not need to request the token, it
is already there in every Actions run.

You can call this action several times in your workflow config if you
need to upload more than one asset per build, for instance if you
compile several binaries with more or fewer features.

To note here is that you should make sure the asset name is unique to
the build (bu including information such as the OS) or it will clash
with assets uploaded from other runs of our matrix.

== Caveats
<caveats>
By running on the GitHub infrastructure the platforms and OS versions
for which you can build these binaries is limited to whatever GitHub has
to offer. However since these encompass the most common OS'es found out
there I think it is worth the effort, especially for smaller projects
that are unable to afford their own build servers.