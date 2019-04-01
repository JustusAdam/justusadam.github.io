---
layout: default
title: Publications
permalink: /bib/
---

# Publications

See also my [Google Scholar user page]({{site.scholar_link}}).

{% assign pubs = site.data.bib | sort: 'date' | reverse %}
{% for p in pubs %}

### [{{ p.title }}]({{p.link}})

<small> {{p.note}} {{ p.authors | join: ", " }} {% if p.publication %}_{{p.publication }}_{% elsif p.institution %}_{{ p.institution }}_{% endif %} {{ p.date }}</small>

{% endfor %}
