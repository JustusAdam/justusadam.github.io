---
title: The Schedule Planner web-app is finally live
author: Justus
---

# The News (TLDR)

Today I worked out the last (major, known to me) kink of my schedule-planner web-app.

It is [live right now](http://justus.science/schedule-planner-web/) (and should work as expected).

Feel free to try it and find bugs. I challenge you :D .

The Website is written in [Elm](http://elm-lang.org), the (Elm) source can be found on [GitHub](https://github.com/JustusAdam/schedule-planner-web). The page itself is deployed on [GitHub Pages](https://pages.github.com).

The actual work is done by the backend server which is pure [Haskell](https://haskell.org), deployed on [Uberspace](http://uberspace.de). And the source is available on [GitHub](https://github.com/JustusAdam/schedule-planner) as well.

## What it does

schedule-planner is an application that, given a list of lessons and a list of rules, calculates the perfect layout for those lessons that adheres to those rules as well as possible.

Currently you can define rules that select either days, timeslots or specific cells (specific timeslot on a specific day) and then assign a weight to it. The higher the weight, the more the algorithm will try to avoid that day/slot/cell.

The application is usable from the command line as a simple tool that takes a json file as input and either prints the result schedules to the command line or emits new json containing the resulting schedules.

The website is a convenient way of inputting the lessons and rules. Also it'll save your input in the browser, so nothing gets lost when you close the browser or reload. There is lots that I'd still like to improve but that'll have to wait.

## The last kink

... I faced was a ting called CORS, or cross origin resource sharing. Now because during the last year or so I have learned of many free services on the internet, I wanted to take advantage of the easy deployment via git on [GitHub pages](https://pages.github.com). But that could not run the Haskell server I am using as backend. So I put the webpage on github pages and the backend server, that only does the calculation on [Uberspace](http://uberspace.de). This has the added benefit that GitHub pages now takes care of serving the html files and relatively large javascript files, while the backend server only deals with a small amount of json for in- and output. This takes some load away from Uberspace.

As a result of having the website on github and the calculation server on a different domain, uberspace, most modern browsers will reject those two talking to one another (by default). Unless one sets a set of so called CORS headers, and it took me a while to do that.

At first I tried to do it by hand, just have the server emit the necessary headers all the time, but that did not seem to work, so I tried adding library to deal with CORS on the server side. That did not work either, because now the server middleware rejected the request outright, because it did not fit the expected CORS protocol (apparently).

Finally, having learned a bit more about CORS headers, I turned back to the original idea of static headers and just added the three required headers (now that I knew them) to the request, and it seems to do the trick.

This does not make the site or your browser vulnerable, as far as I can tell, oso there's no reason to worry. Just try it and have some fun.

## Licensing

Both projects have an open source license (LGPL v3). Feel free to use the code as you'd like, I'd appreciate it if you'd contribute, should you have ideas for improvement/be interested in advancing the project.
