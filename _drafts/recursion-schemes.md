---
author: Justus Adam
title: Practical application of recursion schemes
---

I recently learned about a the very eye opening concept of **recursion schemes**.
Recursion schemes are a ways to traverse recursively defined structures like linked lists, trees (such as AST's) etc.
This might not sound like much, but the basic idea is the following: given a function that handles 1 level of the structure you can use a higher order function to alter the entire structure.
Basically if your data type follows just a few simple rules you get all these generic traversals for free, which in turn save a lot of boilerplate. 

Now this post is not going to be an explanation of recursion schemes themselves, because there are others that have already written such posts and probably better than I would.
The one I leared with and which I enjoyed very much is [this](http://blog.sumtypeofway.com/an-introduction-to-recursion-schemes/) series of posts by [Patrick Thomson](https://twitter.com/importantshock). 
I highly recommend it.
It does a really good job at explaining these progressivley and in very easy to understand terms.
This Post is just going to illustrate some ways in which recursion schemes can be used and general patterns of traversals.

The code in this post is going to be Haskell code, as Haskell already has nice libraries for recursion schemes and very little noise in the code for algebraic datatypes, trees and lists as well as baked in support for concepts `Functor`, `Foldable` and `Traversable`.

The recursion schemes library I will be using for this post is `recursion-schemes` by [Edward Kmett](https://twitter.com/ekmett)

## Making your structure traversably recursive

Where I work I often deal with trees.
Mostly syntax trees which are defined similarly to this one.

```hs
data Expr
  = Let Symbol Expr Expr
  | Apply Expr Expr
  | Var Symbol
  | Lambda Symbol Expr
```

The `recursion-schemes` library defines two type classes for two types of recursion.
I like to refer to them as *destructive* and *constructive*.
They more commonly named *folds* and *unfolds*.
The difference being that *folds* or *destructive* recursions collapse the nested structure into a single value and the *unfold* or *construction* creates a nested structure from a seed value.
However the result of a *fold* may well be another (or the same) nested structure, just the same way as the generative *unfold* may have a nested structure as its seed.
In fact this is a pretty regular ocurrence.

Excuse the tangent, back to topic.

There are two type classes `Recursive` (destructive, folds) and `Corecursive` (constructive, unfolds).

Both of these rely on your type being associated with something called a **base functor** .
A base functor can be thought of as a kidn of *sekeleton* for a single level in your recursive structure.
It is structurally the same but it must not be restricted in the type of the contained value.
This is necessary because, since we wish to derive various traversals with varying types of contained data, we must be able to store arbitrary data in the structure.

For the `Expr` type for instance the **base functor** would look like this.

```
data ExprF a
  = LetF Symbol a a
  | ApplyF a a
  | VarF Symbol
  | LambdaF Symbol a
  deriving (Functor)
```
[^1]


[^1]: You may choose different names for the type and the constructors, but structurally this is the canonical base functor for `Expr`. If you were to choose a structurally different type you would be unable do porperly define either `project` or `embed`. Certainly not in a way that `forall t. cata embed t == ana project t == t`.

Arguably the easiest way to obtain such a base functor is through the use of *Template Haskell*.
The `recursion-schemes` library provides a `makeBaseFunctor` function, which, given a type, creates a base functor like the one we defined above.
However I prefer to do it manually by replacing the original structure with a newtype over the base functor.
I found this to be a really neat trick because it does not introduce a new data type but also `project` and `embed`, the only two functions we will have to implement for the `Recursive` and `Corecursive` instance of our type, and which are called very frequently in these traversals, are now free (no runtime cost).
And using `PatternSynonyms` this change is actually completely backwards compative.

So now our types look like this

```hs
{-# LANGUAGE DeriveFunctor   #-}
{-# LANGUAGE PatternSynonyms #-}

data ExprF a
  = LetF Symbol a a
  | ApplyF a a
  | VarF Symbol
  | LambdaF Symbol a
  deriving (Functor)
	
newtype Expr = Expr (ExprF Expr)

pattern Let s a b = Expr (LetF s a b)
pattern Apply a b = Expr (ApplyF a b)
pattern Var v = Expr (VarF v)
pattern Lambda s b = Expr (LambdaF s b)
```

It's a bit more work to define the patterns, true, however we do not need the old `data Expr` anymore now.
The old `Expr` type is entirely replaced by the `Expr` `newtype`.

Whats nice about this is that we can now implement the `Recursive` and `Corecursive` instance in just 3 lines of code.

```hs
{-# LANGUAGE TypeFamilies #-}
type instance Base Expr = ExprF
instance Recursive Expr where project (Expr e) = e
instance Corecursive Expr where embed = Expr
```

In contrast, if we had kept the old `Expr` type we now would have to define complicated (un)warppings

```
instance Recursive Expr where
  project (Let s a b) = LetF s a b
  project (Apply a b) = ApplyF a b
  project (Var v) = VarF v
  project (Lambda s b) = LambdaF s b

instance Corecursive Expr where
  embed (LetF s a b) = Let s a b
  embed (ApplyF a b) = Apply a b
  embed (VarF v) = Var v
  embed (LambdaF s b) = Lambda s b
```

Granted we don't have to define these by hand if we use `makeBaseFunctor`, but then both `project` and `embed` are still not free.

And there we go.
With this we have both *destructive* and *constructive* recursions enabled for our type.
I do recommend to also derive or implement `Foldable` and `Traversable` on the base functor, as these will come in handy a bit later.
