#import "lib/template.typ": template
#import "lib/socials.typ": socials
#show: template

= Hello There

I'm Justus and I am a PhD student advised by #link("http://cs.brown.edu/people/malte/")[Malte Schwarzkopf] at the
#link("https://cs.brown.edu")[Department of Computer Science] at
#link("https://brown.edu")[Brown University]. I am part of the
_#link("https://etos.cs.brown.edu")[Efficient and Trustworthy Operating Systems]_
(ETOS) group which is part of #link("https://systems.cs.brown.edu")[Systems Research at Brown].

#socials()

== Things I work on

My latest project is *Paralegal*, a static analyzer that finds violations of privacy or security policies in Rust code. The tool supports arbitrary Rust codebases and requires no changes to the application code, other than a few annotations. It supports custom privacy and security policies which lets you tailor the tool to your specific domain and use case. It can also be used on library-only crates. If this interests you, check out the #link("https://brownsys.github.io/paralegal/")[online documentation] and the #link("https://github.com/brownsys/paralegal")[repository].

I contributed to *Kani*, a model checker for Rust programs. I designed and implemented the first contract mechanism for Kani, which enables users to take advantage of modular verification where they can first verify a function against its contract and then use the contract as a cheap assumption when verifying callers. For more information, see my #link("https://model-checking.github.io/kani-verifier-blog/2024/01/29/function-contracts.html")[blog post] on the Kani blog.

I contributed to *Ohua*, a parallelizing compiler. Among other things I implemented an optimization that batches I/O operations to reduce network roundtrips. You can find more information about the compiler on the #link("https://ohua-dev.github.io/")[website].

You may also be interested in the #link("bib.typ")[list] of scientific publications I was involved in.

=== Misc tools

- Online renderings of BQL's kernel schema are #link("bql.typ")[here]

=== Personal stuff

In my spare time I like to climb and boulder, both indoors and outdoors. During the warmer months you'll find me hiking a mountain and during the colder ones on a ski slope if I can help it. I enjoy playing video games, making music and learning about the big issues of our time, like inequality and climate change.

- #link("blog/blog-index.typ")[Archive of a technical blog I used to write]. I haven't posted anything in a long time though

== Did you know?

- The #link("http://daringfireball.net/projects/markdown/syntax")[Markdown] sources for this site are on #link("https://github.com/JustusAdam/justusadam.github.io")[GitHub] and open for you to read, and submit improvement suggestions to. You can also freely use any original content from this site, it is licensed under the #link("legal/license.typ")[Creative Commons License].
- If you happen to find a typo, spelling mistake or straight up false fact, you can simply submit a #link("https://help.github.com/articles/using-pull-requests/")[pull request] to #link("https://github.com/JustusAdam/justusadam.github.io")[the repository] to get it fixed.
