#import "../lib/template.typ": template
#show: template

= Open source icons are awesome

_2015-07-18_

My most recent project is a rewrite of the
#link("https://github.com/elm-lang/elm-reactor")[elm-reacor] in the
#link("http://elm-lang.org")[Elm] language itself, with a better style
(somewhat in the vein of GitHub's style
#link("https://github.com/elm-lang/projects#improve-elm-reactor-navigation-page")[see the mockup]).

To make it pretty I wanted to add icons for files and folders, since
navigating files without icons is just boring. I was pessimistic about
my chances to find good ones, because they'd have to have an an open
license that allows me to use them freely.

In the past I've had plenty of situations where I'd have liked to have
some pretty icons for a (web) project, though I never thought of just
googling for open source icons. This time I did and my first search
immediately yielded
#link("https://github.com/iconic/open-iconic")[this awesome project]
which is a collection of very pretty, MIT licensed icons that you can
use and alter however you want.

I used to think that only the developer community was creating awesome
projects like Linux, Haskell, pandoc, jQuery and such for free and with
publicly available sources. Turns out there are artists doing a very
similar thing with pictures and icons. I am ashamed I didn't think it
possible.

This is what the project looks like right now:

_[Elm Reactor Screenshot — image not available]_

So I've found way more and way prettier icons that I'd hoped for, with
very little effort. I'd strongly encourage you, if you have the need for
some icons or pictures as well, give a search "open source icons" a try,
you'll probably find something awesome.

PS: If the icons are open source
#link("https://git-scm.com/book/en/v2/Git-Tools-Submodules")[git submodules]
is a great way of adding them to your project as dependency that does
not artificially inflate your git repository.

PPS: If you're looking for some fonts I'd also recommend
#link("https://github.com/FontFaceKit/open-sans")[Open Sans] as
sans-serif font and
#link("https://github.com/adobe-fonts/source-code-pro")[Source Code Pro]
as a pretty monospace font.