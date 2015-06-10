---
title: The Schedule Planner web-app is finally live
author: Justus
---

# The News (TLDR)

Today I worked out the last (major, known to me) kink of my schedule-planner web-app.

It is [live right now](http://justus.science/schedule-planner-web/) (and should work as expected).

Feel free to try it and find bugs. I challenge you :D .

The Website is written in [Elm](http://elm-lang.org), the (Elm) source can be found on [GitHub](https://github.com/JustusAdam/schedule-planner-web). The page itself is deployed on [GitHub Pages](https://pages.github.com).

The actual work is done by the backend server which is pure [Haskell](https://haskell.org). And the source is available on [GitHub](https://github.com/JustusAdam/schedule-planner) as well.

## What it does

schedule-planner is an application that, given a list of lessons and a list of rules, calculates the perfect layout for those lessons that adheres to those rules as well as possible.

Currently you can define rules that select either days, timeslots or specific cells (specific timeslot on a specific day) and then assign a weight to it. The higher the weight, the more the algorithm will try to avoid that day/slot/cell.

The application is usable from the command line as a simple tool that takes a json file as input and either prints the result schedules to the command line or emits new json containing the resulting schedules.

The website is a convenient way of inputting the lessons and rules. Also it'll save your input in the browser, so nothing gets lost when you close the browser or reload. There is lots that I'd still like to improve but that'll have to wait.

## Licensing

Both projects have an open source license (LGPL v3). Feel free to use the code as you'd like, I'd appreciate it if you'd contribute, should you have ideas for improvement/be interested in advancing the project.
