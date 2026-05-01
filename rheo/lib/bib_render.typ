#let render-bib(entries) = {
  let sorted = entries.sorted(key: e => e.date).rev()
  for entry in sorted {
    let title-content = if "link" in entry {
      link(entry.link)[*#entry.title*]
    } else {
      [*#entry.title*]
    }

    let other = if "other_links" in entry {
      entry.other_links.pairs().map(((label, url)) => [\[#link(url)[#label]\]]).join(" ")
    }

    let note = entry.at("note", default: none)
    let venue = if note != none {
      [_#note — #entry.at("institution", default: entry.at("publication", default: ""))_]
    } else {
      [_#entry.at("publication", default: "")_]
    }

    let comment = entry.at("comment", default: none)
    let abstract-text = entry.at("abstract", default: none)

    [- #title-content #if other != none [ #other ]

      #entry.authors.join(", ") · #venue · #entry.date

      #if comment != none [#comment]

      #if abstract-text != none {
        block(inset: (left: 1em), text(size: 0.9em, abstract-text))
      }
    ]
  }
}
