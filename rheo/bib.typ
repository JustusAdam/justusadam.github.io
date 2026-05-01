#import "lib/template.typ": template
#import "lib/bib_render.typ": render-bib
#show: template

= Publications

#let entries = yaml("data/bib.yaml")
#render-bib(entries)
