---
author: Justus
title: Recursion - easier then you think
---

## Preface

I think a lot of the confusion that arises when new programmers learn recursion, is that it is often not taught step-by-step, like iteration is, but prefixed with 'we are learning recursion now', a word which will mean little to any non-programmer.

Let's instead look at it step by step and with many examples to better illustrate what it does and how. In the following examples it is very helpful if we think of a function not as a piece of code that does something, but more as an almost mathematical expression which takes some inputs and calculates some new value.

First we'll look at a simple problem.

## Faculty

We'd like to calculate the faculty of any natural number. We'll assume our input is always positive.

```haskell
faculty 0 = 1
faculty 2 = 2
faculty 4 = 24
```

Now we know that just making a list like this and defining faculty for all numbers not going to work since there are infinitely many natural numbers, and an infinite list or function does not fit into a computers memory. So we need to find some generic way of calculating this value. Fortunately the faculty has the a very nice property that exempt 0 any faculty `n!` is equal to the value `n` times the faculty of its predecessor, aka `n! = n * (n-1)!`.

This property is very nicely illustrated by just making a list of expressions calculating sequential faculties:

```haskell
faculty 1 = 1                 = 1
faculty 2 = 1 * 2             = 2
faculty 3 = 1 * 2 * 3         = 12
faculty 4 = 1 * 2 * 3 * 4     = 24
faculty 5 = 1 * 2 * 3 * 4 * 5 = 120
```

Well, lets write that more general in code.

```haskell
faculty n = n * faculty (n - 1)
```

Great. This actually looks quite similar to the mathematical expression `n! = n * (n-1)!` we've had before. But we're not done yet. What about 1? What about 0?

Well, the faculty of 0 is 1. We all know that because it is simply defined as 1. And the faculty of 1 is also safe, because if `0!` is defined as `1` then `1! = 1 * 0! = 1 * 1 = 1`. Great. But our function doesn't reflect that. in it's current form it would try to calculate `0!` by doing `0 * (-1)!` but that is wrong, `(-1)!` is not defined. Even worse, it would try to calculate `(-1)!` as `-1 * (-2)!` and then `(-2)! = -2 * (-3)!` and so on, all the way to negative infinity. We cannot let that happen.

So how do we stop it? We simple define the faculty of 0 to be 1.

```haskell
faculty 0 = 1
faculty n = n * faculty (n - 1)
```

We do this above our original definition so that it will be checked first.

Finally we'll just add a type signature to make it easier on people to understand what we are doing.

```haskell
faculty :: Int -> Int
faculty 0 = 1
faculty n = n * faculty (n - 1)
```

Another example.


## Fibonacci numbers

This one is trickier, because every step of the way we need to know **two** of our predecessors.

We'll try two different approaches, one is the top-down approach, one is the bottom-up approach.

### From the top

This is the more naive approach, but very easy to understand.

Lets first look at what a fibonacci number is. Any n'th fibonacci number is defined as the sum its first and second predecessor, aka `f(n) = f(n-1) + f(n-2).` In code it would look something like this:

```haskell
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)
```

Easy enough. But now we run into the same problem we've had before where it would eventually run off to negative infinity `f(2) = f(1) + f(0)` and then `f(0) = f(-1) + f(-2)`, a very undesirable situation.

So we need a base case. Let's define `f(0)` to be `1`.
