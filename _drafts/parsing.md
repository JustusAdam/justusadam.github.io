---
title: Writing a parser in Haskell, or A Story of retries
---

## Precursor

This is not the first parser I have written in Haskell.
For the [mustache](/projects/mustache) project I also had to write a parser in Haskell.

This time the task was actually very similar, but I had more freedom to the underlying language since I got to decide how that language was going to look.

Generally there are two ways to write parsers these days.
One, define the grammar of your language in some language and have a parser generator such as yacc or alex generate the parser code.
Or, two, use a library of parser combinators to write the parser code yourself.

Since my language is quite simple the former option seemed too much, hence I opted for the second and wrote my parser first using the [attoparsec](https://hackage.haskell.org/package/attoparsec) until I realised attoparsec has the wrong input (and output) type (it uses `Text`, I had `String` and conversion in *both* cases seemed a bad idea).

Perhaps I should tell you the language I actually planned to parse.
For my [marvin](https://marvin.readthedocs.io) project I wanted some nice way to write strings with some data spliced into it.
Marvin is a chatbot framework and as a result a user often has to compose message strings to send, hence the use case.

I used to use format strings for that, but they are a bit of a pain, so in the end I opted to copy my original inspiration hubot again.
In hubot you implement your scripts in CoffeeScript, a language that supports interpolated strings.
This means you can write string literals and splice some data into it like so.

```coffee
v = 4
s = "string"
"My #{s} with data: #{4}"
# "My string with data: 5"
```

And I quite like this approach especially since you can interpolate any expression in the braces.

In Haskell the same behaviour is achievable using various compiler extensions.
In short in Haskell the same code would look something like this

```Haskell
let v = 4
    s = "string"
in $(isS "My #{s} with data: #{4}")
-- "My string with data: 5"
```

This uses a language Extension called `TemplateHaskell` which allows you to run some code generation code at compile time.

## The language

The language then should satisfy the following properties:

- The string bits should let the user write any string. 
    In CoffeeScript this is not true. 
    There is no escape sequence for `#{`, meaning you cannot get a literal `#{` in an interpolated string.
    Also theres a special sequence in Haskell `|]` which is used to end `QuasiQuotes` an extension similar to `TemplateHaskell` which I also support, and this one would also have to be escaped.
- The Haskell expressions should allow any Haskell expression (including those using braces `{}`).


