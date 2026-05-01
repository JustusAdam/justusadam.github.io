#import "../lib/template.typ": template
#show: template

= A logo would be nice.

_2015-04-17_

There's no favicon, that bothers me.

I was thinking about reusing the old logo, but for some reason it does
not appeal to me that much anymore.

So I was thinking I might design a new one. In the includes for the
jekyll standard installation there's an embedded github logo (the one in
the footer) which is a plain svg image and I very much like the idea of
using a plain svg image as logo, because it is so easy to embed and does
not take up any space.

As a result I spent this afternoon tinkering with svg and came up with
something which I like for the moment.

#figure(image("/images/lambda-logo.svg", alt: "A lambda logo"),
  caption: [
    A lambda logo
  ]
)

What I like is that it is very simple but also a little bit clever,
because the lambda hidden within it is not all that visible.

Or perhaps without the line at the bottom?

#figure(image("/images/lambda-logo-sans-linie.svg", alt: "Another lambda logo"),
  caption: [
    Another lambda logo
  ]
)

Or perhaps another color?

#figure(image("/images/lambda-logo-alternative.svg", alt: "Different color"),
  caption: [
    Different color
  ]
)

Or perhaps even filled?

#figure(image("/images/lambda-logo-filled.svg", alt: "A filled logo"),
  caption: [
    A filled logo
  ]
)

I actually quite like this one. It's the filled version but with an
added gradient on top.

#emph[Apparently at least Safari cannot display the following image.
That's the beautiful thing about SVG though it may be able to describe
pictures in a human readable form each implementation is different and,
most of the time, incomplete.
#link("https://www.google.com/chrome/")[Chrome] should display it
correctly though and
#link("https://www.mozilla.org/en-US/firefox/new/")[Firefox] probably as
well.]

#figure(image("/images/lambda-logo-filled-gradient.svg", alt: "Logo with gradient"),
  caption: [
    Logo with gradient
  ]
)

#strong[Edit]: of course it turns out I was drawing the logo the wrong
way around all this time. Well, I fixed it for the last one, will fix it
for whichever one I decide to roll with as well.