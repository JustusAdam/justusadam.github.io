#import "../lib/template.typ": template
#show: template

= Haskell on Travis CI

_2015-09-04_

Building Haskell code on #link("https://travis-ci.org")[travis] is a bit
complicated. Haskell happens to be one of the less well supported
languages on #link("https://travis-ci.org")[travis].

#link("https://travis-ci.org")[Travis] ships with an older version of
ghc (I think its 7.8) and cabal. But many projects either rely on newer
versions of ghc, such as
#link("https://github.com/JustusAdam/elm-init")[elm-init] or want to be
compatible with older ghc, such as
#link("https://github.com/JustusAdam/ja-base-extra")[ja-base-extra].
This requires building with either a different version of ghc or
multiple ghc/base library versions.

There's a wonderful project by a github user named
#link("https://github.com/hvr")[hvr]. The project itself is called
#link("https://github.com/hvr/multi-ghc-travis")[multi-ghc-travis] and
provides an example
#link("https://github.com/hvr/multi-ghc-travis/blob/master/.travis.yml")[\.travis.yml]
which configures a matrix of build environments for travis based on as
many ghc and cabal versions as you require by manually downloading and
installing the necessary ghc ppa's on the build VM.

This is great and all, however bears a downside as it requires root
privileges in the VM to add ppa's and install packages, which prohibits
use of the new and faster, container based travis architecture.

There has been some nice development in container customization lately
and as a result there's now a container compatible way of customizing
your Haskell build environment on travis as this
#link("https://github.com/hvr/multi-ghc-travis#travisyml-for-container-based-infrastructure")[section]
of the #link("https://github.com/hvr/multi-ghc-travis")[README] shows.

The even nicer thing is that the repository also provides you with a
Haskell script that automatically creates the new-style \.travis.yml
from your #strong[tested-with] section in your #strong[\.cabal] file.
Simply provide the script with a #strong[\.cabal] file and pipe the
output into a file called \.travis.yml and you're pretty much set.

Now I found it rather difficult to find information on how the
#strong[tested-with] section in a #strong[\.cabal] file should look. The
#link("https://www.haskell.org/cabal/users-guide/developing-packages.html#package-properties")[cabal documentation]
simply states that it contain #emph[list compiler].

Searching further I found that #emph[compiler] is supposed to be the
short name of a compiler, such as #emph[ghc] version bounds for that
compiler. Those version bounds are very similar to those of
dependencies. Resulting in a field which looks something like this:

```
tested-with:
    GHC >= 7.0 && < 7.10,
    LHC >= 0.6 && < 0.8
```

That's all I've got for now. If you've got something to add
#link("https://twitter.com/justusadam_")[catch me on twitter].