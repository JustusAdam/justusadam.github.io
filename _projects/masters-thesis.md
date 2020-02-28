---
title: The Masters Thesis
github_link: ohua-dev/ohuac
status: finished, actively maintained
languages:
    - Haskell
    - Rust
---


For this project we compiled a lambda calculus based language
([Ohua](https://ohua-dev.github.io)) into database queries with custom (user
defined) operators in [Noria](https://github.com/mit-pdos/noria).

The goal was to make it possible for users to write database queries in a subset
of either rust or ML with the ability to manipulate state and have the compiler
automatically generate operators and query fragments which allows the code to be
efficiently executed and parallelized and to leverage the unique advantages of
the noria system (very high throughput on reads).

If you are interested, there's a [2-page extended
abstract](/pdfs/noria-udfs-extended-abstract.pdf) I wrote that outlines the
basic ideas. You can also [read the full work](/pdfs/thesis.pdf) or look at the
slides of my defence
([pdf](/slides/mt-defence.pdf)|[pptx](/slides/mt-defence.pptx)).
