+++
title = "Hello There"

[extra]
rust_layout = true
mod_name = "hello_there"
+++

{{ const_image(name="ME", src="/me.jpg", alt="A picture of me") }}

Welcome to this, my website.

I'm Justus and I am a PhD student advised by <a target="_blank" href="http://cs.brown.edu/people/malte/">Malte Schwarzkopf</a> at the
<a href="https://cs.brown.edu" target="_blank">Department of Computer Science</a> at
<a href="https://brown.edu" target="_blank">Brown University</a>. I am part of the
_<a href="https://etos.cs.brown.edu" target="_blank">Efficient and Trustworthy Operating Systems</a>_
(ETOS) group which is part of <a href="https://systems.cs.brown.edu" target="_blank">Systems Research at Brown</a>.

{{ socials() }}

{% static_decl(name="NEWS", type="[Event; 2]", doc="Recent happenings.") %}
<ul>
  <li><span class="news-date">2026-05-08</span> — Presented a poster at Northeast Agents Day.</li>
  <li><span class="news-date">2026-04-29</span> — Workshop paper <em><a href="/bib">Towards Practically-Secure Tools for AI Agents</a></em> accepted at EuroMLSys'26.</li>
</ul>
{% end %}

{% fn_section(name="things_i_work_on", doc="What I currently spend my time on.") %}
My latest project is **Paralegal**, a static analyzer that finds violations of privacy or security policies in Rust code. The tool supports arbitrary Rust codebases and requires no changes to the application code, other than a few annotations. It supports custom privacy and security policies which lets you tailor the tool to your specific domain and use case. It can also be used on library-only crates. If this interests you, check out the <a href="https://brownsys.github.io/paralegal/" target="_blank">online documentation</a> and the <a href="//github.com/brownsys/paralegal" target="_blank">repository</a>.

I contributed to **Kani**, a model checker for Rust programs. I designed and implemented the first contract mechanism for Kani, which enables users to take advantage of modular verification where they can first verify a function against its contract and then use the contract as a cheap assumption when verifying callers. For more information, see my [blog post](https://model-checking.github.io/kani-verifier-blog/2024/01/29/function-contracts.html) on the Kani blog.

I contributed to **Ohua**, a parallelizing compiler. Among other things I implemented an optimization that batches I/O operations to reduce network roundtrips. You can find more information about the compiler on the [website](https://ohua-dev.github.io/).

You may also be interested in the [list](/bib) of scientific publications I was involved in.
{% end %}

{% struct_block(name="MiscTools") %}
{{ field(name="schema", type="Link", href="/bql", doc="Online renderings of BQL's kernel schema.") }}
{% end %}

{% fn_section(name="personal_stuff", sub=true) %}
In my spare time I like to climb and boulder, both indoors and outdoors. During the warmer months you'll find me hiking a mountain and during the colder ones on a ski slope if I can help it. I enjoy playing video games, making music and learning about the big issues of our time, like inequality and climate change.

- [Archive of a technical blog I used to write](/blog). I haven't posted anything in a long time though.
{% end %}

{{ const_decl(name="CV", type="Link", value='"/cv.pdf"', href="/cv.pdf") }}
