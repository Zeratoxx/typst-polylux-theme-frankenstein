#import "@preview/polylux:0.3.1": *

// Ratio theme
//
// A highly customizable theme inspired by old Beamer theme Singapore with
// the section names at the top.
//
// The theme's initialization function is at the bottom of this file.

// GLOBAL HELPERS

// Guaranteed array helper. Users often supply a single argument to something that
// should be an array.
#let as-array(value) = {
  if type(value) == array {
    value
  } else {
    (value,)
  }
}

// Recursively update a dictionary.
#let update-dict(dict, update) = {
  for ((key, value)) in update.pairs() {
    if type(value) == dictionary {
      dict.insert(key, update-dict(dict.at(key, default: (:)), value))
    } else {
      dict.insert(key, value)
    }
  }
  dict
}

// Ratio color palette for easy styling.
#let ratio-palette = (
  primary-900: color.hsl(rgb("#1f4ac3")),
  primary-800: color.hsl(rgb("#2c57ce")),
  primary-700: color.hsl(rgb("#3963d9")),
  primary-600: color.hsl(rgb("#4370ec")),
  primary-500: color.hsl(rgb("#4d7cfe")),
  primary-400: color.hsl(rgb("#6890fe")),
  primary-300: color.hsl(rgb("#82a3fe")),
  primary-200: color.hsl(rgb("#82a3fe")),
  primary-100: color.hsl(rgb("#a6beff")),
  primary-50: color.hsl(rgb("#eaefff")),
  secondary-900: color.hsl(rgb("#0f0f25")),
  secondary-800: color.hsl(rgb("#171731")),
  secondary-700: color.hsl(rgb("#1e1e3d")),
  secondary-600: color.hsl(rgb("#232345")),
  secondary-500: color.hsl(rgb("#28284d")),
  secondary-400: color.hsl(rgb("#38385b")),
  secondary-300: color.hsl(rgb("#484868")),
  secondary-200: color.hsl(rgb("#848499")),
  secondary-100: color.hsl(rgb("#bfbfca")),
  secondary-50: color.hsl(rgb("#e5e5ea")),
  contrast: white,
  success: color.hsl(rgb("#8bc34a")),
  warning: color.hsl(rgb("#ff9800")),
  danger: color.hsl(rgb("#f44336")),
  error: color.hsl(rgb("#f44336")),
  info: color.hsl(rgb("#4d7cfe")),
  cat-0: color.hsl(rgb("#e58606")),
  cat-1: color.hsl(rgb("#5d69b1")),
  cat-2: color.hsl(rgb("#52bca3")),
  cat-3: color.hsl(rgb("#99c945")),
  cat-4: color.hsl(rgb("#cc61b0")),
  cat-5: color.hsl(rgb("#24796c")),
  cat-6: color.hsl(rgb("#daa51b")),
  cat-7: color.hsl(rgb("#2f8ac4")),
  cat-8: color.hsl(rgb("#764e9f")),
  cat-9: color.hsl(rgb("#ed645a")),
  cat-10: color.hsl(rgb("#a5aa99")),
  transparent: color.hsl(rgb(0, 0, 0, 0)),
)

// Create a Ratio theme author entry.
#let ratio-author(name, affiliation, email) = {
  (name: name, affiliation: affiliation, email: email)
}

// Ratio default options.
#let ratio-defaults = (
  // Presentation aspect ratio.
  aspect-ratio: "16-9",
  // Presentation title.
  title: [Presentation long title],
  // Presentation title.
  short-title: [Presentation title],
  // An abstract for your work. Can be omitted if you don't have one.
  abstract: lorem(30),
  // Presentation authors/presenters.
  authors: (
    ratio-author("Jane Doe", "Foo Ltd.", "jane.doe@foo.ltd"),
    ratio-author("Foo Bar", "Quux Co.", "foo.bar@quux.co"),
  ),
  // Date that will be displayed on cover page.
  // The value needs to be of the 'datetime' type.
  // More info: https://typst.app/docs/reference/foundations/datetime/
  // Example: datetime(year: 2024, month: 03, day: 17)
  date: datetime.today(),
  date-format: "[day].[month].[year]",
  // Document keywords to set.
  keywords: (),
  // The version of your work.
  version: "Draft",
  // Default font settings.
  text: (font: ("Noto Sans", "Open Sans"), size: 18pt),
  // Whether to register headings as sections and subsections.
  register-headings: true,
  // Whether to apply some heading styling.
  style-headings: true,
  // Whether to apply the custom link style.
  style-links: true,
  // Whether to apply some raw styling.
  style-raw: true,
  // What to show as the "hero" or background image on title slides. `auto` means
  // the theme's default background (auto, content, none).
  hero: auto,
  // What to show in the header ("progress", "progress+location", "short-info", content, none).
  header: "progress+location",
  // What to show in the footer ("progress", "progress+location", "short-info", content, none).
  footer: "short-info",
  // Title background color.
  title-hero-color: ratio-palette.secondary-800,
  // Title text style.
  title-text: (
    font: ("Noto Sans", "Open Sans"),
    size: 20pt,
    fill: ratio-palette.contrast,
  ),
  // Title text heading overrides.
  title-heading-text: (size: 3em, weight: "extrabold"),
  // Title author text heading overrides.
  title-author-text: (:),
  // Title affiliation text overrides.
  title-affiliation-text: (size: 0.7em, weight: "thin"),
  // Title abstract text overrides.
  title-abstract-text: (:),
  // Title date and version text override.
  title-version-text: (size: 0.7em, weight: "thin"),
  // Title vertical spacing.
  title-gutter: 9%,
  // Common heading text style.
  heading-text: (font: ("Noto Sans", "Open Sans"), hyphenate: false),
  // Heading text style overrides in order of heading depth.
  heading-texts: ((fill: ratio-palette.secondary-800),),
  // Heading alignments in order of heading depth.
  heading-alignments: (left,),
  // Slide content box options.
  slide-box: (width: 100%, height: 100%, clip: true),
  // Content slide alignment.
  slide-grid: (
    rows: (auto, 1em, 3fr, auto, 5fr, 1em, auto),
    columns: (auto, 2em, 1fr, auto, 1fr, 2em, auto),
    gutter: 0pt,
  ),
  // Slide grid cell.
  slide-grid-cell: (x: 3, y: 3),
  // Color for external link anchors.
  link-color: ratio-palette.primary-500,
  // Stroke color for tables and such.
  stroke-color: ratio-palette.secondary-100,
  // Fill color for code blocks and such.
  fill-color: ratio-palette.secondary-50,
  // location background color.
  location-bar-color: ratio-palette.secondary-50,
  // location text options for all text.
  location-text: (fill: ratio-palette.secondary-200, size: 0.5em),
  // location text overrides for past sections.
  location-text-past: (:),
  // location text overrides for the current section.
  location-text-current: (weight: "bold"),
  // location text overrides for future sections.
  location-text-future: (:),
  // location shape for past subsections.
  location-shape-past: box(height: 3.8pt, circle(
    radius: 1.7pt,
    fill: ratio-palette.secondary-100,
    stroke: 0.7pt + ratio-palette.secondary-100,
  )),
  // location shape for current subsections.
  location-shape-current: box(height: 3.8pt, circle(
    radius: 1.7pt,
    fill: ratio-palette.primary-500,
    stroke: 0.7pt + ratio-palette.primary-500,
  )),
  // location shape for future subsections.
  location-shape-future: box(
    height: 3.8pt,
    circle(radius: 1.7pt, stroke: 0.7pt + ratio-palette.secondary-100),
  ),
  // Progress bar height.
  progress-bar-height: 5pt,
  // Progress bar background color.
  progress-bar-color: ratio-palette.secondary-50,
  // Progress bar overlay color.
  progress-overlay-color: ratio-palette.secondary-100,
  // Progress bar text color.
  progress-text-color: ratio-palette.secondary-200,
  // Whether to show first author in short information bar.
  show-authors-in-short-info: true,
)

// Variable to hold the options state.
#let ratio-options = state("ratio-options", ratio-defaults)

// Register new options or replace existing keys.
#let ratio-option-register(options) = {
  ratio-options.update(s => {
    s = s + options
    s
  })
}

// Update options by replacing values and updating dictionaries.
#let ratio-option-update(options) = {
  ratio-options.update(s => update-dict(s, options))
}

// Draw a tiny anchor on the top right of the body text.
#let ratio-link-anchor(body, color: ratio-defaults.link-color) = {
  box[#body#h(0.05em)#box(height: .7em, text(size: .4em, fill: color)[#emoji.chain])]
  // box[#body#h(0.05em)#super(box(height: 0.7em, circle(radius: 0.15em, stroke: 0.08em + color)))]
}

// TITLE SLIDE

// Ratio custom background image.
#let ratio-hero(fill: ratio-defaults.title-hero-color) = {
  // Build the background.
  place(block(width: 100%, height: 100%, fill: fill))
  // The left triangle.
  place(
    left + top,
    polygon(
      fill: fill.lighten(20%).transparentize(50%),
      (0%, 100%),
      (25%, 80%),
      (0%, 70%),
    ),
  )
  // The bottom triangle.
  place(
    left + top,
    polygon(
      fill: fill.lighten(20%).transparentize(20%),
      (0%, 100%),
      (25%, 80%),
      (75%, 100%),
    ),
  )
  // The large one on the right.
  place(
    left + top,
    polygon(
      fill: fill.lighten(20%).transparentize(85%),
      (0%, 100%),
      (100%, 100%),
      (100%, 20%),
    ),
  )
}

// Ratio title text content. Draws only from defaults, fully customizable.
#let ratio-title-content(
  title: ratio-defaults.title,
  authors: ratio-defaults.authors,
  abstract: ratio-defaults.abstract,
  date: ratio-defaults.date,
  date-format: ratio-defaults.date-format,
  version: ratio-defaults.version,
  keywords: ratio-defaults.keywords,
  title-text: ratio-defaults.title-text,
  heading-text: ratio-defaults.title-heading-text,
  author-text: ratio-defaults.title-author-text,
  affiliation-text: ratio-defaults.title-affiliation-text,
  abstract-text: ratio-defaults.title-abstract-text,
  version-text: ratio-defaults.title-version-text,
  gutter: ratio-defaults.title-gutter,
  register-section: false,
) = {
  set text(..title-text)

  let rows = ()

  if title != none {
    rows.push(text(..heading-text)[#title])
    if register-section {
      utils.register-section(title)
    }
  }

  if authors != none and authors.len() > 0 {
    for author in as-array(authors) {
      let name = author.at("name", default: none)
      let email = author.at("email", default: none)
      let affiliation = author.at("affiliation", default: none)
      let content = {
        let author-text = text(..author-text)[#name]

        if email == none {
          author-text
        } else {
          link("mailto:" + email)[#author-text]
        }

        if affiliation != none {
          v(0.3em, weak: true)
          text(..affiliation-text)[#affiliation]
        }
      }
      rows.push(content)
    }
  }

  if abstract != none {
    rows.push([
      #set text(..abstract-text)
      #abstract
    ])
  }

  let date-line = ()
  if date != none {
    date-line.push(date.display(date-format))
  }
  if version != none {
    date-line.push(version)
  }
  if keywords != none and keywords.len() > 0 {
    let keywords = as-array(keywords)
    date-line.push(keywords.join(", "))
  }

  if date-line.len() > 0 {
    let sep = [
      #h(1.6pt)
      |
      #h(1.6pt)
    ]

    rows.push([
      #set text(..version-text)
      #date-line.join(sep)
    ])
  }

  grid(columns: (auto), gutter: gutter, ..rows)
}

// Ratio style title slide.
// Draws options from context that are not in the parameter list.
#let title-slide(
  // Slide title.
  title: none,
  // Document authors/presenters.
  authors: none,
  // Presentation abstract or subtitle.
  abstract: none,
  // Presentation date. Set to none to hide.
  date: none,
  // Presentation version. Set to none to hide.
  version: none,
  // Presentation keywords. Set to none to hide.
  keywords: none,
  // Foreground content to show (in front of regular title page content).
  foreground: none,
  // Background content to show (behind regular title page content).
  background: none,
  // What to show as the "hero" or background image on title slides.
  // auto means the theme's default background (auto, content, none).
  hero: auto,
  // Whether to register this slide title as a section.
  register-section: false,
) = {
  let content = context {
    let options = ratio-options.get()

    if hero == auto {
      let fill = options.title-hero-color
      if fill != none {
        ratio-hero(fill: fill)
      }
    } else {
      place(top + left, block(width: 100%, height: 100%, hero))
    }

    if background != none {
      background
    }

    align(
      left + horizon,
      block(
        width: 100%,
        inset: 15%,
        ratio-title-content(
          title: title,
          authors: authors,
          abstract: abstract,
          date: date,
          date-format: options.date-format,
          version: version,
          keywords: keywords,
          title-text: options.title-text,
          heading-text: options.title-heading-text,
          author-text: options.title-author-text,
          affiliation-text: options.title-affiliation-text,
          abstract-text: options.title-abstract-text,
          version-text: options.title-version-text,
          gutter: options.title-gutter,
        ),
      ),
    )

    if foreground != none {
      foreground
    }
  }
  logic.polylux-slide(content)
}

// CONTENT SLIDE HELPERS

// Ratio progress bar. Draws everything from options.
#let ratio-progress-bar() = {
  locate(loc => {
    let options = ratio-options.at(loc)
    let current = loc.page()
    let total = counter(page).final().first()
    block(
      fill: options.progress-bar-color,
      width: 100%,
      below: 0pt,
      above: 0pt,
      height: options.progress-bar-height,
      place(
        left + horizon,
        clearance: 0pt,
        utils.polylux-progress(ratio => block(
          fill: options.progress-overlay-color,
          width: ratio * 100%,
          height: 100%,
        )),
      ),
    )
  })
}

// Ratio style section location info bar. Draws everything from options.
#let ratio-location-info(show-location: true) = {
  locate(loc => {
    // Get the variables at this stage or final.
    let options = ratio-options.at(loc)
    let page = loc.page()
    let secs = utils.sections-state.final()

    set text(..options.location-text)

    // Precalculate when sections and subsections end.
    let sec_ends = {
      if secs.len() > 1 {
        secs.slice(1).map(s => s.loc.page())
      } else {
        ()
      }
    }
    sec_ends.push(none)

    let sec_display = {
      let curr_sec = secs.zip(sec_ends).map(((sec, end)) => {
      (sec: sec, end: end)
    }).find( e => {
          return page == e.sec.loc.page() or (e.end != none and page < e.end)
        })
      if curr_sec != none {
        curr_sec.sec.body
      }
    }

    // Combine into a block that fills the header.
    block(
      fill: options.location-bar-color,
      width: 100%,
      ratio-progress-bar() + if show-location {
        align(
          horizon,
          {
            pad(
              x: 2em,
              y: 1.4em,
              grid(
              columns: (1fr,1fr),
              gutter: .4em,
              none, // TODO Logo
              align(right,text(..options.location-text-current)[#sec_display]) // TODO not correct
            ),
            )
          },
        )
      },
    )
  })
}

// Ratio style short information bar. Draws everything from options.
#let ratio-short-info() = {
  locate(loc => {
    // Get the variables at this stage or final.
    let options = ratio-options.at(loc)
    let page = loc.page()

    set text(..options.location-text)

    // Precalculate when sections and subsections end.
    let content = {
      ()
    }
    content.push(
      text(options.date.display("[day].[month].[year]")),
    )

    if options.show-authors-in-short-info and options.authors != none and options.authors.len() > 0 {
      content.push(
        align(
          center,
          text(options.short-title + " — " + options.authors.at(0).name + " — " + options.authors.at(0).affiliation),
        ),
      )

    } else {
      content.push(
        align(center, text(options.short-title)),
      )
    }

    content.push(
      align(right, text(str(page))),
    )

    // Combine into a block that fills the header.
    block(
      fill: options.location-bar-color,
      width: 100%,
      align(
        horizon,
        {
          pad(
            x: 2em,
            y: 1.4em,
            grid(
              columns: (1fr, 15fr, 1fr),
              gutter: .4em,
              ..content,
            ),
          )
        },
      ),
    )
  })
}

// Ratio header or footer bar helper.
#let ratio-bar(kind) = {
  if kind == "progress+location" {
    ratio-location-info()
  } else if kind == "progress" {
    ratio-location-info(show-location: false)
  } else if kind == "short-info" {
    ratio-short-info()
  } else if kind == none {
    []
  } else {
    kind
  }
}

// Ratio header helper.
#let ratio-header() = (
  context {
    ratio-bar(
      ratio-options.get().at(
        "header",
        default: none,
      ),
    )
  }
)

// Ratio footer helper.
#let ratio-footer() = (
  context {
    ratio-bar(
      ratio-options.get().at(
        "footer",
        default: none,
      ),
    )
  }
)

// Ratio content box helper. Wraps it in a box+grid combination.
#let ratio-content(
  box-args: auto,
  grid-args: auto,
  grid-cell: auto,
  grid-children: auto,
  body,
) = {
  context {
    let options = ratio-options.get()

    let grid-children = if grid-children == auto {
      options.grid-children
    } else if grid-children == none {
      ()
    } else {
      as-array(grid-children)
    }

    let g = if grid-args == auto {
      grid.with(..options.slide-grid)
    } else if grid-args == none {
      none
    } else {
      grid.with(..grid-args)
    }

    let body = if g == none {
      body
    } else {
      if grid-cell == auto {
        g(grid.cell(..options.slide-grid-cell, body), ..grid-children)
      } else if grid-cell == none {
        if type(body) == array {
          g(..body, ..grid-children)
        } else {
          body
        }
      } else {
        g(grid.cell(..grid-cell, body), ..grid-children)
      }
    }

    let body = if box-args == auto {
      box(..options.slide-box, body)
    } else if box-args == none {
      body
    } else {
      box(..box-args, body)
    }
    body
  }
}

// CONTENT SLIDES

// Ratio style slide.
#let slide(
  title: none,
  depth: 1,
  header: auto,
  footer: auto,
  box-args: auto,
  grid-args: auto,
  grid-cell: auto,
  grid-children: (),
  body,
) = {
  let inner = {
    if title != none {
      heading(depth: depth, box(width: 100%, align(center, title)))
    }
    body
  }
  let content = ratio-content(
    box-args: box-args,
    grid-args: grid-args,
    grid-cell: grid-cell,
    grid-children: grid-children,
    inner,
  )
  let header = if header == auto {
    ratio-header()
  } else {
    header
  }
  let footer = if footer == auto {
    ratio-footer()
  } else {
    footer
  }
  logic.polylux-slide(
    grid(
      columns: 1,
      gutter: 0pt,
      rows: (auto, 1fr, auto),
      ..(header, content, footer),
    ),
  )
}

// Ratio style centered slide.
#let centered-slide(
  title: none,
  depth: 1,
  header: auto,
  footer: auto,
  box-args: auto,
  body,
) = {
  slide(
    title: title,
    depth: depth,
    header: header,
    footer: footer,
    box-args: box-args,
    grid-args: none,
    align(horizon + center, box(body)),
  )
}

// Ratio style bare bones slide.
#let bare-slide = logic.polylux-slide


#let title-slide2(title: [], subtitle: none, author: [], date: none) = {
  let title-block(fg, bg, height, body) = block(
    width: 100%,
    height: height,
    outset: 0em,
    inset: 0em,
    breakable: false,
    stroke: none,
    spacing: 0em,
    fill: bg,
    align(center + horizon, text(fill: fg, body)),
  )
  let content = {
    title-block(frankenstein-dark, frankenstein-bright, 60%, text(1.7em, title))
    title-block(
      frankenstein-bright,
      frankenstein-dark,
      40%,
      {
        if subtitle != none {
          text(size: 1.2em, subtitle)
          parbreak()
        }

        text(
          size: .9em,
          {
            author
            if date != none {
              h(1em)
              sym.dot.c
              h(1em)
              date
            }
          },
        )
      },
    )
    place(
      center + horizon,
      dy: 10%,
      rect(width: 6em, height: .5em, radius: .25em, fill: frankenstein-accent),
    )
  }
  logic.polylux-slide(content)
}

#let _frankenstein-content-box(fg, bg, width, alignment, body) = box(
  width: width,
  height: 100%,
  outset: 0em,
  inset: (x: 1em),
  baseline: 0em,
  stroke: none,
  fill: bg,
  align(alignment + horizon, text(fill: fg, body)),
)

#let west-slide(title: none, body) = {
  let content = {
    _frankenstein-content-box(
      frankenstein-bright,
      frankenstein-dark,
      30%,
      left,
      if title != none {
        heading(level: 2, title)
      } else {
        []
      },
    )
    _frankenstein-content-box(frankenstein-dark, frankenstein-bright, 70%, left, body)
  }
  logic.polylux-slide(content)
}

#let east-slide(title: none, body) = {
  let content = {
    _frankenstein-content-box(frankenstein-dark, frankenstein-bright, 70%, right, body)
    _frankenstein-content-box(
      frankenstein-bright,
      frankenstein-dark,
      30%,
      right,
      if title != none {
        heading(level: 2, title)
      } else {
        []
      },
    )
  }
  logic.polylux-slide(content)
}

#let split-slide(body-left, body-right) = {
  let content = {
    _frankenstein-content-box(frankenstein-dark, frankenstein-bright, 50%, right, body-left)
    _frankenstein-content-box(frankenstein-bright, frankenstein-dark, 50%, left, body-right)
  }
  logic.polylux-slide(content)
}


#let slide2(
  title: none,
  header: none,
  footer: none,
  new-section: none,
  body,
) = {

  let body = pad(x: 2em, y: .5em, body)

  let progress-barline = locate(loc => {
    if frankenstein-progress-bar.at(loc) {
      let cell = block.with(width: 100%, height: 100%, above: 0pt, below: 0pt, breakable: false)
      let colors = frankenstein-colors.at(loc)

      utils.polylux-progress(ratio => {
        grid(
          rows: 2pt,
          columns: (ratio * 100%, 1fr),
          cell(fill: colors.a), cell(fill: colors.b),
        )
      })
    } else {
      []
    }
  })

  let header-text = {
    if header != none {
      header
    } else if title != none {
      if new-section != none {
        utils.register-section(new-section)
      }
      locate(loc => {
        let colors = frankenstein-colors.at(loc)
        block(
          fill: colors.c,
          inset: (x: .5em),
          grid(
            columns: (60%, 40%),
            align(top + left, heading(level: 2, text(fill: colors.a, title))),
            align(top + right, text(fill: colors.a.lighten(65%), utils.current-section)),
          ),
        )
      })
    } else {
      []
    }
  }

  let header = {
    set align(top)
    grid(rows: (auto, auto), row-gutter: 3mm, progress-barline, header-text)
  }

  let footer = {
    set text(size: 10pt)
    set align(center + bottom)
    let cell(fill: none, it) = rect(
      width: 100%,
      height: 100%,
      inset: 1mm,
      outset: 0mm,
      fill: fill,
      stroke: none,
      align(horizon, text(fill: white, it)),
    )
    if footer != none {
      footer
    } else {
      locate(loc => {
        let colors = frankenstein-colors.at(loc)

        show: block.with(width: 100%, height: auto, fill: colors.b)
        grid(
          columns: (25%, 1fr, 15%, 10%),
          rows: (1.5em, auto),
          cell(fill: colors.a, frankenstein-short-author.display()),
          cell(frankenstein-short-title.display()),
          cell(frankenstein-short-date.display()),
          cell(logic.logical-slide.display() + [~/~] + utils.last-slide-number),
        )
      })
    }
  }


  set page(
    margin: (top: 2em, bottom: 1em, x: 0em),
    header: header,
    footer: footer,
    footer-descent: 0em,
    header-ascent: .6em,
  )

  logic.polylux-slide(body)
}

// THEME

// The Ratio theme function that sets up all styling and show rules once.
// Any provided options update the defaults by recursively updating the
// options dictionary. I.e. setting: `options: (title-text: (fill: red))`
// Only changes the title text's fill to red and maintains other options.
// You can view all defaults in the `ratio-defaults` variable.
#let ratio-theme(
  // Presentation aspect ratio.
  aspect-ratio: "16-9",
  // Whether to include the default cover page.
  cover: true,
  // Presentation title.
  title: [Presentation title],
  // An abstract for your work. Can be omitted if you don't have one.
  abstract: lorem(30),
  // Presentation authors/presenters.
  authors: (
    ratio-author("Jane Doe", "Foo Ltd.", "jane.doe@foo.ltd"),
    ratio-author("Foo Bar", "Quux Co.", "foo.bar@quux.co"),
  ),
  // Date that will be displayed on cover page.
  // The value needs to be of the 'datetime' type.
  // More info: https://typst.app/docs/reference/foundations/datetime/
  // Example: datetime(year: 2024, month: 03, day: 17)
  date: datetime.today(),
  // Document keywords to set.
  keywords: (),
  // The version of your work.
  version: "Draft",
  // Ratio theme options.
  options: (:),
  // Presentation contents.
  body,
) = {
  let keywords = {
    if keywords == none {
      ()
    } else {
      keywords
    }
  }
  // Set document properties.
  set document(
    title: title,
    author: authors.first().name,
    date: date,
    keywords: keywords,
  )

  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0em,
    header: none,
    footer: none,
  )

  // Update all options.
  let options = options + (
    aspect-ratio: aspect-ratio,
    title: title,
    abstract: abstract,
    authors: authors,
    date: date,
    keywords: keywords,
    version: version,
  )
  ratio-option-update(options)

  // Text setup.
  set par(leading: 0.7em, justify: true, linebreaks: "optimized")
  show par: set block(spacing: 1.35em)

  // Any text
  show: it => (
    context {
      set text(..ratio-options.get().text)
      it
    }
  )

  // Heading setup.
  show heading: it => (
    context {
      let options = ratio-options.get()
      if options.register-headings and logic.subslide.get().first() == 1 {
        // Register sections and subsections.
        if it.depth == 1 {
          utils.register-section(it.body)
        }
      }
      if options.style-headings {
        let depth = it.depth - 1

        let alignments = as-array(options.heading-alignments)
        let value = if depth < alignments.len() {
          alignments.at(depth)
        } else if alignments.len() > 0 {
          alignments.last()
        } else {
          none
        }
        set align(value)

        let texts = as-array(options.heading-texts)
        let style = if depth < texts.len() {
          texts.at(depth)
        } else if texts.len() > 0 {
          texts.last()
        } else {
          (:)
        }
        // Do not hyphenate headings.
        text(..options.heading-text, ..style)[#it]
      } else {
        it
      }
    }
  )

  // Style links if set.
  show link: it => (
    context {
      let options = ratio-options.get()
      if options.style-links {
        // Don't style for internal links.
        if type(it.dest) == label or type(it.dest) == location {
          return it
        }
        let color = options.at("link-color", default: ratio-palette.primary-500)
        ratio-link-anchor(it)
      } else {
        it
      }
    }
  )

  // Set raw font to Fira Code if available.
  show raw.where(block: true): it => (
    context {
      let options = ratio-options.get()
      if options.style-raw {
        set text(font: "Fira Code")
        block(
          inset: (x: .3em),
          fill: options.fill-color.lighten(25%),
          outset: (y: .5em),
          radius: .15em,
          it,
        )
      } else {
        it
      }
    }
  )

  show raw.where(block: false): it => (
    context {
      let options = ratio-options.get()
      if options.style-raw {
        set text(font: "Fira Code")
        box(
          fill: options.fill-color,
          inset: (x: .3em),
          outset: (y: .3em),
          radius: .15em,
          it,
        )
      } else {
        it
      }
    }
  )

  // Title slide if set.
  if cover {
    title-slide(
      title: title,
      authors: authors,
      abstract: abstract,
      date: date,
      version: version,
      keywords: keywords,
      // Pick the option without another context.
      hero: options.at("hero", default: ratio-defaults.hero),
      register-section: false, // Don't register the cover.
    )
  }

  // Presentation contents.
  body
}