+++
template = "page.html"
title = "BQL Tools"

[extra]
rust_layout = true
mod_name = "bql"
+++

Online hosted tools for dealing with BQL.

{% struct_block(name="SchemaBrowsers") %}
{{ field(name="small", type="Link", href="schema-viewer.html?schema=schema/small-schema.json", doc="Compact schema.") }}
{{ field(name="base",  type="Link", href="schema-viewer.html?schema=schema/base-schema.json",  doc="Very large (180k hooks); takes a moment to load.") }}
{% end %}
