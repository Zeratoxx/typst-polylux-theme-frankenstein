#import "@preview/polylux:0.3.1": *

// frankenstein theme
//
// A highly customizable theme inspired by old Beamer theme Singapore with
// the section names at the top.
//
// The theme's initialization function is at the bottom of this file.

// GLOBAL HELPERS

// Guaranteed array helper. Users often supply a single argument to something that
// should be an array.
#let _as-array(value) = {
  if type(value) == array {
    value
  } else {
    (value,)
  }
}

// Recursively update a dictionary.
#let _update-dict(dict, update) = {
  for ((key, value)) in update.pairs() {
    if type(value) == dictionary {
      dict.insert(key, _update-dict(dict.at(key, default: (:)), value))
    } else {
      dict.insert(key, value)
    }
  }
  dict
}

#let frankenstein-list(content) = (
  layout(size => [
    #let text-size = measure([#content])
    #let proper-width = text-size.width + 50pt
    #if proper-width > size.width {
      proper-width = size.width
    }

    #move(
      dx: 10pt,
      block(
      // fill: black.transparentize(50%),
      width: proper-width)[
      #set enum(numbering: "a.1.")
      #content
    ],
    )])
)

// frankenstein color palette for easy styling.
#let _frankenstein-palette = (
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

// Create a frankenstein theme author entry.
#let frankenstein-author(name, affiliation, email) = {
  (name: name, affiliation: affiliation, email: email)
}

// frankenstein default options.
#let _frankenstein-defaults = (
  // Presentation aspect frankenstein.
  aspect-ratio: "16-9",
  // Presentation title.
  title: [Presentation long title],
  // Presentation title.
  short-title: [Presentation title],
  // An abstract for your work. Can be omitted if you don't have one.
  abstract: lorem(10),
  // Presentation authors/presenters.
  authors: (
    frankenstein-author("Jane Doe", "Foo Ltd.", "jane.doe@foo.ltd"),
    frankenstein-author("Foo Bar", "Quux Co.", "foo.bar@quux.co"),
  ),
  graphics-path: "../images/",
  light-logo-filename: none,
  dark-logo-filename: none,
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
  text: (font: ("Inter", "Lato", "Noto Sans", "Open Sans"), size: 16pt),
  // Default language settings.
  lang: "en",
  // Whether to register headings as sections and subsections.
  register-headings: true,
  // Whether to apply some heading styling.
  style-headings: true,
  // Whether to apply some heading styling.
  draw-headings-separation: true,
  // Whether to apply the custom link style.
  style-links: true,
  // Whether to apply some raw styling.
  style-raw: true,
  // What to show as the "hero" or background image on title slides. `auto` means
  // the theme's default background (auto, content, none).
  hero: auto,
  // What to show in the header ("progress", "progress+location", "short-info-top", "short-info-bottom", content, none).
  header: "progress+location",
  // What to show in the footer ("progress", "progress+location", "short-info-top", "short-info-bottom", content, none).
  footer: "short-info-bottom",
  // Title background color.
  title-hero-color: _frankenstein-palette.secondary-800,
  // Title text style.
  title-text: (
    font: ("Segoe UI", "Cantarell", "Inter", "Noto Sans", "Open Sans"),
    size: 20pt,
    fill: _frankenstein-palette.contrast,
  ),
  // Title text heading overrides.
  title-heading-text: (size: 2.5em, weight: "bold", hyphenate: false),
  // Title author text heading overrides.
  title-author-text: (:),
  // Title affiliation text overrides.
  title-affiliation-text: (size: 0.7em, weight: "light"),
  // Title abstract text overrides.
  title-abstract-text: (:),
  // Title date and version text override.
  title-version-text: (size: 0.7em, weight: "light"),
  // Title vertical spacing.
  title-gutter: 9%,
  // Common heading text style.
  heading-text: (font: ("Inter", "Cantarell", "Noto Sans", "Open Sans"), hyphenate: false, weight: "medium",tracking: .03em),
  // Heading text style overrides in order of heading depth.
  heading-texts: (
    (/* depth 1 */fill: _frankenstein-palette.secondary-800, size: 1.2em, tracking: .02em),
    (/* depth 2 */size: 1.15em,),
    (/* depth 3 */size: 1.1em, ), /* depth ... */
  ),
  // Heading alignments in order of heading depth.
  heading-alignments: (left,),
  // Slide content box options.
  slide-box: (width: 100%, height: 100%, clip: true),
  // Content slide alignment.
  slide-grid: (
    rows: (auto, 1em, 3fr, auto, 5fr, 3.5em, auto),
    columns: (auto, 3.5em, 1fr, auto, 1fr, 3.5em, auto),
    gutter: 0pt
  ),
  grid-children: (),
  // Slide grid cell.
  slide-grid-cell: (x: 3, y: 3),
  // Color for external link anchors.
  link-color: _frankenstein-palette.primary-500,
  // Stroke color for tables and such.
  stroke-color: _frankenstein-palette.secondary-100,
  // Fill color for code blocks and such.
  fill-color: _frankenstein-palette.secondary-50,
  // location background color.
  location-bar-color: _frankenstein-palette.secondary-50,
  // location text options for all text.
  location-text: (fill: _frankenstein-palette.secondary-200, size: .5em),
  // location text overrides for past sections.
  location-text-past: (:),
  // location text overrides for the current section.
  location-text-current: (weight: "medium", size: 1.25em),
  // location text overrides for future sections.
  location-text-future: (:),
  // location shape for past subsections.
  location-shape-past: box(
    height: 3.8pt,
    circle(radius: 1.7pt, fill: _frankenstein-palette.secondary-100, stroke: 0.7pt + _frankenstein-palette.secondary-100),
  ),
  // location shape for current subsections.
  location-shape-current: box(
    height: 3.8pt,
    circle(radius: 1.7pt, fill: _frankenstein-palette.primary-500, stroke: 0.7pt + _frankenstein-palette.primary-500),
  ),
  // location shape for future subsections.
  location-shape-future: box(height: 3.8pt, circle(radius: 1.7pt, stroke: 0.7pt + _frankenstein-palette.secondary-100)),
  // Progress bar height.
  progress-bar-height: 5pt,
  // Progress bar background color.
  progress-bar-color: _frankenstein-palette.secondary-50,
  // Progress bar overlay color.
  progress-overlay-color: _frankenstein-palette.secondary-100,
  // Progress bar text color.
  progress-text-color: _frankenstein-palette.secondary-200,
  // Whether to show first author in short information bar.
  show-authors-in-short-info: true,
)

// Variable to hold the options state.
#let frankenstein-options = state("frankenstein-options", _frankenstein-defaults)

// Register new options or replace existing keys.
#let frankenstein-option-register(options) = {
  frankenstein-options.update(s => {
    s = s + options
    s
  })
}

// Update options by replacing values and updating dictionaries.
#let frankenstein-option-update(options) = {
  frankenstein-options.update(s => _update-dict(s, options))
}

// Draw a tiny anchor on the top right of the body text.
#let frankenstein-link-anchor(body, color: _frankenstein-defaults.link-color) = {
  box[#body#h(0.05em)#box(height: 1em, text(size: .4em, fill: color)[#emoji.chain])]
  // box[#body#h(0.05em)#super(box(height: 0.7em, circle(radius: 0.15em, stroke: 0.08em + color)))]
}

// TITLE SLIDE

// frankenstein custom background image.
#let _frankenstein-hero(fill: _frankenstein-defaults.title-hero-color) = {
  // Build the background.
  place(block(width: 100%, height: 100%, fill: fill))
  // The left triangle.
  place(left + top, polygon(fill: fill.lighten(20%).transparentize(50%), (0%, 100%), (25%, 80%), (0%, 70%)))
  // The bottom triangle.
  place(left + top, polygon(fill: fill.lighten(20%).transparentize(20%), (0%, 100%), (25%, 80%), (75%, 100%)))
  // The large one on the right.
  place(left + top, polygon(fill: fill.lighten(20%).transparentize(85%), (0%, 100%), (100%, 100%), (100%, 20%)))
}

#let frankenstein-image(filename, image-args: ()) = layout(size => (
  context {
    [
      #pad(
        x: 2%,
        top: 2%,
        bottom: 15%,
        move(
          dy: 10pt,
          image(frankenstein-options.get().at("graphics-path", default: "") + filename, fit: "contain", ..image-args),
        ),
      )
    ]
  }
))

#let frankenstein-image-plain(filename, image-args: ()) = (
  context {
    image(frankenstein-options.get().at("graphics-path", default: "") + filename, fit: "contain", ..image-args)
  }
)

// frankenstein title text content. Draws only from defaults, fully customizable.
#let _frankenstein-title-content(
  title: _frankenstein-defaults.title,
  authors: _frankenstein-defaults.authors,
  abstract: _frankenstein-defaults.abstract,
  date: _frankenstein-defaults.date,
  date-format: _frankenstein-defaults.date-format,
  version: _frankenstein-defaults.version,
  keywords: _frankenstein-defaults.keywords,
  title-text: _frankenstein-defaults.title-text,
  heading-text: _frankenstein-defaults.title-heading-text,
  author-text: _frankenstein-defaults.title-author-text,
  affiliation-text: _frankenstein-defaults.title-affiliation-text,
  abstract-text: _frankenstein-defaults.title-abstract-text,
  version-text: _frankenstein-defaults.title-version-text,
  gutter: _frankenstein-defaults.title-gutter,
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
    for author in _as-array(authors) {
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
    let keywords = _as-array(keywords)
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

#let place-logo(logo-hint, graphics-path: auto) = (
  context {
    let options = frankenstein-options.get()
    let actual-path = if graphics-path == auto {
      options.graphics-path
    } else {
      graphics-path
    }
    if type(actual-path) == str {
      let logo-filename = ""
      if type(logo-hint) == str {
        logo-filename = logo-hint
      } else if type(logo-hint) == color {
        if logo-hint == white {

          logo-filename = options.light-logo-filename
        } else {

          logo-filename = options.dark-logo-filename
        }
      }
      place(
        right + top,
        pad(
          right: 2em,
          top: 2em,
          image(actual-path + logo-filename, fit: "contain", alt: "logo", height: 2.5em),
        ),
      )
    }
  }
)

// frankenstein style title slide.
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
  body: none
) = {
  let content = context {
    let options = frankenstein-options.get()

    let title2 = title
    let authors2 = authors
    let abstract2 = abstract
    let date2 = date
    let version2 = version
    let keywords2 = keywords
    let hero2 = hero

    if hero == auto {
      hero2 = options.at("hero", default: _frankenstein-defaults.hero)
    }
    if hero2 == auto {
      let fill = options.title-hero-color
      if fill != none {
        _frankenstein-hero(fill: fill)
      }
    } else {
      place(top + left, block(width: 100%, height: 100%, hero2))
    }

    if title2 == none {
      title2 = options.title
    }
    if authors2 == none {
      authors2 = options.authors
    }
    if abstract2 == none {
      abstract2 = options.abstract
    }
    if date2 == none {
      date2 = options.date
    }
    if version2 == none {
      version2 = options.version
    }
    if keywords2 == none {
      keywords2 = options.keywords
    }

    if background != none {
      background
    }

    place-logo(white)

    align(
      left + horizon,
      block(
        width: 100%,
        inset: 15%,
        _frankenstein-title-content(
          title: title2,
          authors: authors2,
          abstract: abstract2,
          date: date2,
          date-format: options.date-format,
          version: version2,
          keywords: keywords2,
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
  logic.polylux-slide(max-repetitions: 3, content + body)
}

// CONTENT SLIDE HELPERS

// frankenstein progress bar. Draws everything from options.
#let frankenstein-progress-bar(height: auto, progress-color: auto, background-color: auto) = {
  locate(loc => {
    let options = frankenstein-options.at(loc)
    let current = loc.page()
    let total = counter(page).final().first()

    let bar-height = if height == auto {
      options.progress-bar-height
    } else {
      height
    }

    let bar-progress-color = if progress-color == auto {
      options.progress-overlay-color
    } else {
      assert(
        type(progress-color) == color,
        message: "argument 'progress-color' needs to be a color, got type '" + type(progress-color) + "'",
      )
      progress-color
    }

    let bar-background-color = if background-color == auto {
      options.progress-bar-color
    } else {
      assert(
        type(background-color) == color,
        message: "argument 'background-color' needs to be a color, got type '" + type(background-color) + "'",
      )
      background-color
    }

    block(
      fill: bar-background-color,
      width: 100%,
      below: 0pt,
      above: 0pt,
      height: bar-height,
      place(
        left + horizon,
        clearance: 0pt,
        utils.polylux-progress(frankenstein => block(
          fill: bar-progress-color,
          width: frankenstein * 100%,
          height: 100%,
        )),
      ),
    )
  })
}

// frankenstein style section location info bar. Draws everything from options.
#let frankenstein-location-info(show-location: true) = {
  locate(loc => {
    // Get the variables at this stage or final.
    let options = frankenstein-options.at(loc)
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
      let curr_sec = if secs.len() > 0 {
        let page-first-sec = secs.at(0).loc.page()
        secs
          .zip(sec_ends)
          .map(((sec, end)) => {
              (sec: sec, end: end)
            })
          .find(entry => {
          // Returns false if the location of the first section haven't been reached yet.
          // Returns always true after reaching the location of the first section but only at specific position caused by the order of the OR arguments.
          // Priority decreases from left to right.
          return page >= page-first-sec and (
            page == entry.sec.loc.page() or (entry.end != none and page <= entry.end) or entry.end == none
          )
        })
      } else {
        none
      }
      if curr_sec != none {
        curr_sec.sec.body
      }
    }

    // Combine into a block that fills the header.
    block(
      fill: options.location-bar-color,
      width: 100%,
      frankenstein-progress-bar() + if show-location {
        align(
          horizon,
          {
            pad(
              x: 4em,
              y: 1.4em,
              grid(
                columns: (1fr, 1fr, 1fr),
                gutter: .4em,
                align(left,
                  box(
                    text(..options.location-text-current)[
                      #place(
                        move(dx: -2em, dy: -.26em,
                          circle(radius: .65em, inset: 2pt, stroke: _frankenstein-palette.primary-100.darken(20%).transparentize(80%))[
                            #circle(stroke: _frankenstein-palette.primary-100.darken(20%).transparentize(80%), fill: _frankenstein-palette.primary-100.darken(20%).transparentize(80%))
                          ]
                        )
                      )
                      #sec_display
                    ]
                  )
                ),
                // debug
                // text()[#secs] + text()[#sec_ends],
                none,
                if type(options.graphics-path) == str and type(options.dark-logo-filename) == str {
                  align(right, image(options.graphics-path + options.dark-logo-filename, fit: "contain", alt: "logo", height: 4em))
                } else {
                  none
                },
              ),
            )
          },
        )
      },
    )
  })
}

// frankenstein style short information bar. Draws everything from options.
#let frankenstein-short-info(
  align_y,
  leftsize: 2fr,
  centersize: 6fr,
  rightsize: 2fr,
  pad-left: 4em,
  pad-right: 3em,
  pad-y: 2em,
  show-page-number: true,
) = {
  locate(loc => {
    // Get the variables at this stage or final.
    let options = frankenstein-options.at(loc)
    let page = loc.page()

    set text(..options.location-text)

    // Precalculate when sections and subsections end.
    let content = {
      ()
    }
    content.push(pad(left: pad-left, text(options.date.display(options.date-format))))

    let center-content = options.short-title
    if center-content == [] or center-content == none {
      center-content = ""
    }
    if options.show-authors-in-short-info and options.authors != none and options.authors.len() > 0 {
      if center-content != "" or center-content != [] or center-content != none {
        center-content += linebreak()
      }
      center-content += options.authors.at(0).name + if options.authors.at(0).affiliation != "" and options.authors.at(0).affiliation != [] and options.authors.at(0).affiliation != none {" — " + options.authors.at(0).affiliation}
    }

    content.push(align(center, text(center-content)))

    content.push(
      align(
        right,
        pad(
          right: pad-right,
          text(if show-page-number {
            str(page)
          } else {
            []
          }),
        ),
      ),
    )

    // Combine into a block that fills the header.
    // TODO block fill color through options
    place(
      align_y,
      block(
        fill: _frankenstein-palette.transparent,
        width: 100%,
        align(
          horizon,
          {
            pad(y: pad-y, grid(columns: (leftsize, centersize, rightsize), gutter: .4em, ..content))
          },
        ),
      ),
    )
  })
}

// frankenstein header or footer bar helper.
#let frankenstein-bar(kind) = {
  if kind == "progress+location" {
    frankenstein-location-info()
  } else if kind == "progress" {
    frankenstein-location-info(show-location: false)
  } else if kind == "short-info-top" {
    frankenstein-short-info(top)
  } else if kind == "short-info-bottom" {
    frankenstein-short-info(bottom)
  } else if kind == none {
    []
  } else {
    kind
  }
}

// frankenstein header helper.
#let _frankenstein-header() = (
  context {
    frankenstein-bar(frankenstein-options.get().at("header", default: none))
  }
)

// frankenstein footer helper.
#let _frankenstein-footer() = (
  context {
    frankenstein-bar(frankenstein-options.get().at("footer", default: none))
  }
)

// frankenstein content box helper. Wraps it in a box+grid combination.
#let _frankenstein-content(box-args: auto, grid-args: auto, grid-cell: auto, grid-children: auto, body) = {
  context {
    let options = frankenstein-options.get()

    let grid-children = if grid-children == auto {
      options.grid-children
    } else if grid-children == none {
      ()
    } else {
      _as-array(grid-children)
    }

    let the-grid = if grid-args == auto {
      grid.with(..options.slide-grid)
    } else if grid-args == none {
      none
    } else {
      grid.with(..grid-args)
    }

    let body = if the-grid == none {
      body
    } else {
      if grid-cell == auto {
        the-grid(grid.cell(..options.slide-grid-cell, body), ..grid-children)
      } else if grid-cell == none {
        if type(body) == array {
          the-grid(..body, ..grid-children)
        } else {
          body
        }
      } else {
        the-grid(grid.cell(..grid-cell, body), ..grid-children)
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


#let _frankenstein-split-content-box(
  fg,
  // bg, // fill: bg breaks images in split content
  width,
  alignment,
  body,
  inset_left: none,
  inset_right: none,
  inset_top: none,
  inset_bottom: none,
  inset_x: 2em,
  inset_y: 1em,
  grid-children: (),
) = {
  let scaler = 1
  if type(width) == ratio {
    scaler = width
  }
  if inset_top == none {
    inset_top = inset_y * scaler
  }
  if inset_bottom == none {
    inset_bottom = inset_y * scaler * 3.5
  }
  if inset_left == none {
    inset_left = inset_x * scaler
  }
  if inset_right == none {
    inset_right = inset_x * scaler
  }

  let offset_top = 3fr
  let offset_bottom = 3fr
  let offset_left = 1fr
  let offset_right = 1fr
  if alignment.x == left {
    offset_right = 3fr
  } else if alignment.x == right {
    offset_left = 3fr
  }

  _frankenstein-content(
    box-args: (width: width, height: 100%, clip: true, /* fill: bg */), // ???????? fill: bg breaks split content??!
    grid-args: (
      rows: (auto, inset_top, offset_top, auto, offset_bottom, inset_bottom, auto),
      columns: (auto, inset_left, offset_left, auto, offset_right, inset_right, auto),
      gutter: 0pt,
    ),
    grid-cell: (x: 3, y: 3),
    grid-children: grid-children,
    align(alignment + horizon, box(align(left, text(fill: fg, body)))),
  )
}

// CONTENT SLIDES

// frankenstein style slide.
#let slide(
  title,
  do-outline-register: true,
  depth: 2,
  header: auto,
  footer: auto,
  box-args: auto,
  grid-args: auto,
  grid-cell: auto,
  grid-children: (),
  body,
) = {
  if title != none and type(title) != str {
    panic("argument 'title' need to be a string, got type '" + type(title) + "' with value '" + str(title) + "'")
  }
  if type(do-outline-register) != bool {
    panic("argument 'do-outline-register' need to be a boolean, got type '" + type(do-outline-register) + "' with value '" + str(do-outline-register) + "'")
  }
  context {
    let title-display
    if title != none {
      let should-get-outlined = depth == 1 and do-outline-register
      title-display = block( /* fill: black.transparentize(50%),  */
        pad(
          top: 1em,
          bottom: 3.7em,
          heading(outlined: should-get-outlined)[#title] + if frankenstein-options.get().draw-headings-separation {
            place(bottom, dy: 18pt, dx: 10pt, line(stroke: 1pt + _frankenstein-palette.primary-900, length: 77pt))
          },
        ),
      )
    }
    let should-place-logo = false
    let header = if header == auto {
      _frankenstein-header()
      if frankenstein-options.get().header == "progress" {
        should-place-logo = true
      }
    } else {
      header
    }
    let footer = if footer == auto {
      _frankenstein-footer()
    } else {
      footer
    }
    let inner = {
      stack(dir: ttb, title-display, body)
    }
    let content = _frankenstein-content(
      box-args: box-args,
      grid-args: grid-args,
      grid-cell: grid-cell,
      grid-children: grid-children,
      inner,
    )
    logic.polylux-slide(
      max-repetitions: 3,
      grid(columns: 1, gutter: 0pt, rows: (auto, 1fr, auto), ..(header, content, footer)),
    )
    if should-place-logo {
      place-logo(black)
    }
  }
}

// TODO buggy.. fix bugginess
#let WIP-two-column-slide(
  title,
  do-outline-register: true,
  depth: 2,
  header: auto,
  footer: auto,
  box-args: auto,
  grid-args: auto,
  grid-cell: auto,
  grid-children: (),
  body1,
  body2,
) = {
  let body = grid(
    rows: 1,
    columns: (auto, auto, auto),
    gutter: 1em,
    body1, line(start: (50%, 15%), end: (50%, 30%), stroke: .5pt + _frankenstein-palette.secondary-200), body2,
  )

  slide(
    title,
    do-outline-register: do-outline-register,
    depth: depth,
    header: header,
    footer: footer,
    box-args: box-args,
    grid-args: grid-args,
    grid-cell: grid-cell,
    grid-children: grid-children,
    body,
  )
}

#let new-section-slide(
  section-title,
  subtitle: none,
  uppercase-subtitle: true,
  do-outline-register: true,
  header: none,
  footer: auto,
  body,
) = (
  context {
    let options = frankenstein-options.get()

    if type(section-title) != str {
      panic("argument 'section-title' need to be a string, got type '" + type(section-title) + "' with value '" + str(section-title) + "'")
    }
    if subtitle != none and type(subtitle) != str {
      panic("argument 'section-subtitle' need to be a string, got type '" + type(subtitle) + "' with value '" + str(subtitle) + "'")
    }
    if do-outline-register {
      utils.register-section(section-title)
    }

    let heading-display = if options.style-headings {
      let depth = 0

      let texts = _as-array(options.heading-texts)
      let style = if depth < texts.len() {
        texts.at(depth)
      } else {
        (:)
      }
      // Do not hyphenate headings.
      text(
        ..options.heading-text,
        ..style,
        fill: _frankenstein-palette.primary-500.darken(50%).desaturate(50%),
        weight: "thin",
        tracking: 1pt,
        size: 45pt,
      )[#section-title]
    } else {
      section-title
    }

    let content = {

      set align(horizon)
      set enum(spacing: 1em)
      show: pad.with(20%)
      block(heading-display)
      v(1em)
      block(height: 2pt, width: 100%, spacing: 0pt, frankenstein-progress-bar(height: 2pt))
      if subtitle != none and subtitle != "" {
        let proper-subtitle = subtitle
        if uppercase-subtitle {
          proper-subtitle = upper(subtitle)
        }
        text(fill: _frankenstein-palette.secondary-200, proper-subtitle)
      }
      if body != [] {
        linebreak()
        v(1.5em)
        set text(fill: _frankenstein-palette.cat-1)
        box(width: 100%, pad(x: 7%, body))
      }
    }
    slide(none, header: header, footer: footer, grid-args: none, content)
  }
)

// frankenstein style centered slide.
#let centered-slide(title, do-outline-register: true, depth: 2, header: auto, footer: auto, box-args: auto, body) = {
  context {
    if title != none and type(title) != str {
      panic("argument 'title' need to be a string, got type '" + type(title) + "' with value '" + str(title) + "'")
    }
    if type(do-outline-register) != bool {
      panic("argument 'do-outline-register' need to be a boolean, got type '" + type(do-outline-register) + "' with value '" + str(do-outline-register) + "'")
    }
    let lower-fraction = 5fr
    if title == none {
      lower-fraction = 3fr
    }
    slide(
      title,
      do-outline-register: do-outline-register,
      depth: depth,
      header: header,
      footer: footer,
      box-args: box-args,
      grid-args: (
        rows: (auto, 1em, 3fr, auto, lower-fraction, 1em, auto),
        columns: (auto, 2em, 1fr, auto, 1fr, 2em, auto),
        gutter: 0pt,
      ),
      grid-cell: (..frankenstein-options.get().slide-grid-cell, align: horizon + center),
      body,
    )
  }
}

// frankenstein style bare bones slide.
#let bare-slide = logic.polylux-slide

#let west-slide(
  title,
  depth: 2,
  do-outline-register: true,
  subtitle: none,
  title-width: 30%,
  hyphenate: true,
  header: auto,
  footer: auto,
  body,
) = {
  let content = context {
    frankenstein-option-update((heading-text: (hyphenate: true)))
    box(
      fill: frankenstein-options.get().location-bar-color,
      _frankenstein-split-content-box(
        _frankenstein-palette.secondary-900,
        title-width,
        center,
        if title != none {
          heading(depth: depth, outlined: do-outline-register, title)
          v(.5em)
          text(fill: _frankenstein-palette.secondary-300, size: .9em, hyphenate: hyphenate, subtitle)
        } else {
          []
        },
      ),
    )
    frankenstein-option-update((heading-text: (hyphenate: false)))
    _frankenstein-split-content-box(
      _frankenstein-palette.secondary-600,
      (100% - title-width),
      left,
      inset_right: 4em,
      inset_left: 7em,
      body,
    )
  }

  slide(
    none,
    depth: depth,
    do-outline-register: do-outline-register,
    header: header,
    footer: footer,
    grid-args: none,
    content,
  )
}

#let east-slide(
  title,
  depth: 2,
  do-outline-register: true,
  subtitle: none,
  title-width: 30%,
  hyphenate: true,
  header: auto,
  footer: auto,
  body,
) = {
  let content = context {
    _frankenstein-split-content-box(
      _frankenstein-palette.secondary-900,
      (100% - title-width),
      right,
      inset_right: 7em,
      inset_left: 4em,
      body,
    )
    frankenstein-option-update((heading-text: (hyphenate: true)))
    box(
      fill: frankenstein-options.get().location-bar-color,
      _frankenstein-split-content-box(
        _frankenstein-palette.secondary-900,
        title-width,
        center,
        if title != none {
          heading(depth: depth, outlined: do-outline-register, title)
          v(.5em)
          text(fill: _frankenstein-palette.secondary-300, size: .9em, hyphenate: hyphenate, subtitle)
        } else {
          []
        },
      ),
    )
    frankenstein-option-update((heading-text: (hyphenate: false)))
  }

  slide(
    none,
    depth: depth,
    do-outline-register: do-outline-register,
    header: header,
    footer: footer,
    grid-args: none,
    content,
  )
}

// TODO
#let WIP_title-slide2(title, subtitle: none, author: [], date: none) = {
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
    title-block(_frankenstein-palette.primary-900, _frankenstein-palette.secondary-50, 60%, text(1.7em, title))
    title-block(
      _frankenstein-palette.secondary-50,
      _frankenstein-palette.primary-900,
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
    place(center + horizon, dy: 10%, rect(width: 6em, height: .5em, radius: .25em, fill: frankenstein-accent))
  }
  logic.polylux-slide(content)
}

// TODO
#let WIP_split-slide(body-left, body-right) = {
  let content = {
    _frankenstein-split-content-box(
      _frankenstein-palette.primary-900,
      _frankenstein-palette.secondary-50,
      50%,
      right,
      body-left,
    )
    _frankenstein-split-content-box(
      _frankenstein-palette.secondary-50,
      _frankenstein-palette.primary-900,
      50%,
      left,
      body-right,
    )
  }
  logic.polylux-slide(content)
}

// TODO
#let WIP_slide2(title, header: none, footer: none, new-section: none, body) = {
  let body = pad(x: 2em, y: .5em, body)

  let progress-barline = locate(loc => {
    if frankenstein-progress-bar.at(loc) {
      let cell = block.with(width: 100%, height: 100%, above: 0pt, below: 0pt, breakable: false)
      let colors = frankenstein-colors.at(loc)

      utils.polylux-progress(frankenstein => {
        grid(
          rows: 2pt,
          columns: (frankenstein * 100%, 1fr),
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

#let frankenstein-outline(numbering: "I.") = {
  if numbering == auto {
    numbering = "I."
  }
  text(
    size: 18pt,
    utils.polylux-outline(enum-args: (
      tight: false,
      body-indent: .9em,
      spacing: 1.6em,
      numbering: numbering,
    )),
  )
}

// frankenstein style slide.
#let frankenstein-outline-slide(title, depth: 1, header: none, footer: auto, numbering: auto) = west-slide(
  title,
  depth: depth,
  do-outline-register: false,
  header: header,
  footer: footer,
)[#frankenstein-outline(numbering: numbering)]

// THEME

// The frankenstein theme function that sets up all styling and show rules once.
// Any provided options update the defaults by recursively updating the
// options dictionary. I.e. setting: `options: (title-text: (fill: red))`
// Only changes the title text's fill to red and maintains other options.
// You can view all defaults in the `frankenstein-defaults` variable.
#let frankenstein-theme(
  // Presentation aspect frankenstein.
  aspect-ratio: "16-9",
  // Whether to include the default cover page.
  cover: true,
  // Presentation title.
  title: [Presentation title],
  // An abstract for your work. Can be omitted if you don't have one.
  abstract: lorem(30),
  // Presentation authors/presenters.
  authors: (
    frankenstein-author("Jane Doe", "Foo Ltd.", "jane.doe@foo.ltd"),
    frankenstein-author("Foo Bar", "Quux Co.", "foo.bar@quux.co"),
  ),
  graphics-path: "../images/",
  // Filename to dark logo
  dark-logo-filename: none,
  // Filename to light logo
  light-logo-filename: none,
  // Date that will be displayed on cover page.
  // The value needs to be of the 'datetime' type.
  // More info: https://typst.app/docs/reference/foundations/datetime/
  // Example: datetime(year: 2024, month: 03, day: 17)
  date: datetime.today(),
  // Document keywords to set.
  keywords: (),
  // The version of your work.
  version: "Draft",
  // frankenstein language.
  lang: "en",
  // pdfpc configs
  pdfpc-config: none,
  // frankenstein theme options.
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
  set document(title: title, author: authors.first().name, date: date, keywords: keywords)

  set page(paper: "presentation-" + aspect-ratio, margin: 0em, header: none, footer: none)

  if pdfpc-config != none {
    pdfpc.config(..pdfpc-config)
  }

  // Update all options.
  let options = options + (
    aspect-ratio: aspect-ratio,
    title: title,
    abstract: abstract,
    authors: authors,
    date: date,
    keywords: keywords,
    version: version,
    lang: lang,
    graphics-path: graphics-path,
    dark-logo-filename: dark-logo-filename,
    light-logo-filename: light-logo-filename,
  )
  frankenstein-option-update(options)

  let list-marker1(content) = pad(top: -.05em, text(size: 1.2em, fill: _frankenstein-palette.primary-700, [#content]))
  let list-marker2(content) = pad(top: 0.01em, text(size: .9em, fill: _frankenstein-palette.primary-500, [#content]))
  let list-marker3(content) = pad(top: .02em, text(size: .9em, fill: _frankenstein-palette.primary-400, [#content]))
  let list-marker4(content) = pad(top: -.1em, text(size: 1.2em, fill: _frankenstein-palette.primary-300, [#content]))
  let list-marker5(content) = pad(top: -.1em, text(size: 1.1em, fill: _frankenstein-palette.primary-200, [#content]))

  // Text setup.
  set par(leading: 0.7em, justify: true, linebreaks: "optimized")
  show par: set block(spacing: 1.35em)
  set enum(
    numbering: "I.a.1.",
    tight: false,
    spacing: 1.8em,
    body-indent: 1.25em,
    indent: -10pt,
  )
  set list(
    marker: (list-marker1[⬢], list-marker2[⬟], list-marker3[⬥], list-marker4[▸], list-marker5[--]),
    tight: false,
    spacing: 1.8em,
    body-indent: 1.25em,
    indent: -10pt,
  )

  // Any text
  show: it => (
    context {
      set text(lang: frankenstein-options.get().lang, ..frankenstein-options.get().text)
      it
    }
  )

  // Heading setup.
  show heading: it => (
    context {
      let options = frankenstein-options.get()
      if options.register-headings and logic.subslide.get().first() == 1 and it.outlined {
        // Register sections and subsections.
        if it.depth == 1 {
          utils.register-section(it.body)
        }
      }
      if options.style-headings {
        let depth = it.depth - 1

        let alignments = _as-array(options.heading-alignments)
        let value = if depth < alignments.len() {
          alignments.at(depth)
        } else if alignments.len() > 0 {
          alignments.last()
        } else {
          none
        }
        set align(value)

        let texts = _as-array(options.heading-texts)
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
      let options = frankenstein-options.get()
      if options.style-links {
        // Don't style for internal links.
        if type(it.dest) == label or type(it.dest) == location {
          return it
        }
        let color = options.at("link-color", default: _frankenstein-palette.primary-500)
        frankenstein-link-anchor(it)
      } else {
        it
      }
    }
  )

  // Set raw font to Fira Code if available.
  show raw.where(block: true): it => (
    context {
      let options = frankenstein-options.get()
      if options.style-raw {
        set text(font: "Fira Code")
        block(inset: (x: .3em), fill: options.fill-color.lighten(25%), outset: (y: .5em), radius: .15em, it)
      } else {
        it
      }
    }
  )

  show raw.where(block: false): it => (
    context {
      let options = frankenstein-options.get()
      if options.style-raw {
        set text(font: "Fira Code")
        box(fill: options.fill-color, inset: (x: .3em), outset: (y: .3em), radius: .15em, it)
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
      hero: options.at("hero", default: _frankenstein-defaults.hero),
      register-section: false, // Don't register the cover.
    )
  }

  // Presentation contents.
  body
}