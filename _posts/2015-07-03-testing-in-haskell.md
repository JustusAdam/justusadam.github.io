---
title: Unittesting in Haskell
author: Justus
---

I have, of late, been writing a bunch of smaller programs in [Haskell](https://haskell.org). Simple things like [counting some codelines][hlinecount], [renaming a lot of files simultaneously](https://github.com/JustusAdam/hrename) and [pinging a server until it answers](https://github.com/JustusAdam/hpingserver).
For the most part, if your project is as small as these are, there's no automated testing required. The functionality has a very small scope and is well defined so it is usually enough to just see if it works yourself.

[hlinecount]: https://github.com/JustusAdam/hlinecount

However my code line counting tool ([hlinecount]) is different. I wanted to make it more extensible and not hard code the actual counters, file filters and so on. So I had to refactor the code in a mayor way.[^hlcrefac]

[^hlcrefac]:
    What I ended up doing was creating three `newtype`'s [`Counter`](https://github.com/JustusAdam/hlinecount/blob/master/src/LineCount/Counter.hs), [`FileFilter`](https://github.com/JustusAdam/hlinecount/blob/master/src/LineCount/Filter.hs) and [`Selector`](https://github.com/JustusAdam/hlinecount/blob/master/src/LineCount/Select.hs). It is then possible to define individual filters and counters etc., with a small and well defined scope, that can be chained together (they form a Monoid since they are just functions).
    Each of the source files for these Structures defines the basic ones, accumulates them in a List, which is then folded over to create the actual Filter/Counter/Selector.

As is to be expected following the refactoring (and major effort to get the code to compile) the program didn't work anymore. Some errors became quite obvious quite quickly with some debugging, but some turned out to be much harder. For some strange reason the FileFilters kept rejecting every file that was thrown at them and as such it became necessary to start writing tests.

Now I had never written a single test in Haskell. I had heard of [QuickCheck](https://hackage.haskell.org/package/QuickCheck) but I hadn't actually used it yet. I also knew QuickCheck wasn't the tool I needed right now. I wasn't that my software was going to go into production and I had to check for corner cases through random testing. No, I required good old fashion unit tests to see which Filter was causing the problem or whether or not it was perhaps the chaining of those filters.

So I started looking at [hspec](https://hackage.haskell.org/package/hspec). Hspec is a library designed to basically imitate [RSpec](http://rspec.info), a popular [Ruby](https://ruby-lang.org) testing tool, designed to enable you to write very easy and comfortable to read tests, by structuring the library so the code using it would almost look like normal, valid english sentences.
