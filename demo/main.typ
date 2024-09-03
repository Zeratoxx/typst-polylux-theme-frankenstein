#import "@preview/polylux:0.3.1": *

#import "../theme/frankenstein.typ": *

#show: frankenstein-theme.with(
  cover: true,
  aspect-ratio: "16-9",
  title: [Frankenstein theme],
  abstract: [A theme about navigation and customization],
  authors: (frankenstein-author("Theme Author 1", "123456", "foo@bar.quux"),),
  version: "1.0.0",
  date: datetime(year: 2024, month: 8, day: 28),
  keywords: ("progress", "customization", "short informations"),
  lang: "de",
  options: (show-authors-in-short-info: true),
)

#frankenstein-option-register((short-title: [#lorem(10)]))

#centered-slide(none, header: frankenstein-bar("progress"))[#heading(outlined: false)[Welcome!]]

#frankenstein-outline-slide()

#slide("Theme setup", depth: 2)[
  The title page was the result of:

  ```typ
  #import themes.frankenstein: *
  #show: frankenstein-theme.with(
    cover: true,
    aspect-ratio: "16-9",
    title: [frankenstein theme],
    abstract: [A theme about navigation and customization],
    authors: (frankenstein-author("Theme Author", "Typst Community", "foo@bar.quux"),),
    version: "1.0.0",
    date: datetime(year: 2024, month: 4, day: 4),
    keywords: ("navigation", "customization"),
    lang
    options: (:),
  )
  ```

  Which automatically generates a cover page if `cover` is set to `true`.
]

#new-section-slide("Navigation")

#slide("Navigation")[
  Have you noticed the navigation bar at the top?

  You can press the main section titles, or just one of the subsection dots.

  Also, there's a progress bar at the bottom by default.

  == Subsections become dots

  The current section's dot is always "alight".

  == So there's two dots for "Navigation"!

  And they're both alight since we're on this page.

]

#slide(none)[
  The last subsection is still active because we haven't registered a new section
  yet!

  #text(weight: "extrabold", font: "Segoe UI")[extrabold]
]

#slide(none)[

  #utils.register-section("Manual sections")

  == Adding manual subsections

  You can also manually register a new section using:

  ```typ
  #utils.register-section("Manual sections")
  ```

  Which is what we did at the start of this slide's code.

  == Toggle headings registration
  If you don't want headings to be registered by default, you can switch it
  on/off:

  ```typ
  #frankenstein-update((register-headings: false))
  ```
]

#centered-slide(none)[#heading(depth: 2)[Hello there!]]

#slide("Customization")[

  #set text(size: 15pt)
  We all know that layouts work all of the time 99% of the time.

  The `frankenstein-update` function updates option dictionaries *recursively* and thus
  only updates what you specify.

  The `frankenstein-register` function replaces values *completely*.

  There's a handy `frankenstein-palette` variable with a pre-configured color palette,
  but feel free to bring your own!

  ```typ
  // Only update the heading color, not it's size:
  #frankenstein-update((title-text: (fill: frankenstein-palette.warning))) // <- Notice the palette!
  // Next title slide will feature a green background.
  #frankenstein-register((title-hero-color: color.hsl(green)))
  // Let's add some foreground and background content this time. We can place it anywhere!
  #let fg = place(horizon + left, block(inset: 10%, width: 100%)[foreground.])
  #let bg = place(
    horizon + left,
    block(inset: 30%, width: 100%)[#text(weight: "bold")[background.]],
  )
  #title-slide(title: "Green", register-section: true, foreground: fg, background: bg)
  // This becomes...=>
  ```
]

// #frankenstein-option-update((title-text: (fill: frankenstein-palette.warning)))
// #frankenstein-option-register((title-hero-color: color.hsl(green)))
// #let fg = place(horizon + left, block(inset: 10%, width: 100%)[foreground.])
// #let bg = place(
//   horizon + left,
//   block(inset: 30%, width: 100%)[#text(weight: "bold")[background.]],
// )
// #title-slide(title: "Green", register-section: true, foreground: fg, background: bg)

#slide("Slide layout")[

  == Alignment grid

  By default frankenstein uses a 7x7 `grid` wrapped in a content `box` that fills the
  page's space \
  between the header and footer. The grid has the following specifications:

  ```typ
  #let slide-grid = (
    rows: (auto, 1em, 3fr, auto, 5fr, 1em, auto),
    columns: (auto, 2em, 1fr, auto, 1fr, 2.5em, auto),
    gutter: 0pt,
  )
  ```

  Which achieves:
  - edge content possible using placements in the first and last columns
  - followed by padding around the main content
  - content in the middle `(auto, auto)` cell
  - "spring-loaded" positioning using the `fr` rows and columns
    - The defaults roughly center the content on screen and push it slightly above the
      horizon.
]

#slide("Customizing the grid", depth: 2, grid-children: (grid.cell(x: 6, rowspan: 7, fill: red, align: horizon)[cell]))[
  The default slide function `#slide` allows for customization of this grid using
  the `grid-args` and `grid-cell` keyword arguments per slide.

  - `grid-args` fully customize the grid.
    - `auto` means to use the grid settings from theme options.
    - `none` means to disable the grid.
    - anything else is treated as keyword arguments to `#grid`
  - `grid-cell` the cell at which to put the body.
    - `auto` means to put it at the cell as defined in theme options.
    - `none` means to check if the body is an array:
      - if it's an array, pass the array to `#grid` as the contents.
      - if not, disable the grid functionality and use body as is.
  - `grid-children` children to place on the grid. The bar on the right was achieved
    with:\
    `grid-children: (grid.cell(x: 6, rowspan: 7, fill: red),)`
]

#slide("Customizing the grid", depth: 2, grid-args: (
    rows: (auto, 2em, 3fr, auto, 5fr, 1em, auto),
    columns: (auto, 2em, 1fr, 10fr, 1fr, 2em, 2fr),
    gutter: 0pt,
  ), grid-children: (grid.cell(x: 6, rowspan: 7, fill: red, align: horizon)[cell]))[
  The default slide function `#slide` allows for customization of this grid using
  the `grid-args` and `grid-cell` keyword arguments per slide.

  - `grid-args` fully customize the grid.
    - `auto` means to use the grid settings from theme options.
    - `none` means to disable the grid.
    - anything else is treated as keyword arguments to `#grid`
  - `grid-cell` the cell at which to put the body.
    - `auto` means to put it at the cell as defined in theme options.
    - `none` means to check if the body is an array:
      - if it's an array, pass the array to `#grid` as the contents.
      - if not, disable the grid functionality and use body as is.
  - `grid-children` children to place on the grid. The bar on the right was achieved
    with:\
    `grid-children: (grid.cell(x: 6, rowspan: 7, fill: red),)`
]

#frankenstein-option-register((
  slide-grid: (columns: (5em, auto, 10em), rows: (1em, auto, 2em)),
  slide-grid-cell: (x: 1, y: 1),
))

#slide("Custom grid", depth: 2)[

  If you're not satisfied with the default grid, you can tweak things in the init
  function, too.

  ```typ
  #show: frankenstein-theme.with(
    //..,
    options: (
      slide-grid: (
        columns: (5em, auto, 10em),
        rows: (1em, auto, 2em),
      ),
      slide-grid-cell: (x: 1, y: 1),
    ),
  )
  ```
]