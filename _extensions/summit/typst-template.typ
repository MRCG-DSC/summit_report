
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates

#let parse-date(date) = {
  let date = date.replace("\\", "")
  let date = str(date).split("-").map(int)
  datetime(year: date.at(0), month: date.at(1), day: date.at(2))
}

#let article(
  title: none,
  subtitle: none,
  when: none,
  institutions: (
    (
      logo: "mrcg.svg"
    ),
    (
      logo: "lshtm.png"
    ),
    (
      logo: "andes.png"
    ),
    (
      logo: "javeriana.png"
    ),
    (
      logo: "data_org.png"
    ),
  ),
  date: none,
  abstract: none,
  cols: 1,
  margin: (x: 1.5cm, y: 5cm),
  paper: "a4",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 14pt,
  sectionnumbering: none,
  toc: false,
  doc,
) = {
  set rect(
    width: 100%,
    height: 100%,
    inset: 0pt,
  )

  set page(
    header: context {
    if counter(page).get().first() > 1 [
        #let start = parse-date("2024-11-26")
        #let duration = duration(days: 5)
        #let end = start + duration
      #align(right + horizon)[#block(inset: -1.5em)[
      #text(
        font: "Clash Display Variable",
        size: 0.9em,
        fill: rgb("#106BA0")
        )[#subtitle \ 
          #start.display("[day]") - #end.display("[day]  [month repr:long]")
         ]
    ]]
      ]
    },
    paper: paper,
    margin: margin,
    header-ascent: 2cm,
    footer: context {
      // box(
      //   rotate(30deg,
      //     polygon.regular(
      //       vertices: 6,
      //       fill: rgb("#F04A4C"),
      //       size: 4em,
      //     )
      //   )
      // + place(dx: 1.5em, dy: -2.5em, text(
      //   font: "Clash Display Variable",
      //   size: 2em, 
      //   fill: white, 
      //   [
      //     #set align(center + horizon)
      //     #counter(page).display( "1")
      //   ]))
      // )

      [
        #circle(
          fill: none, //rgb("#F04A4C"),
          stroke: none,
          radius: 3.7em,
          )[
            #text(
            font: "Clash Display Variable",
            size: 4em,
            fill: white,
            )[
              #set align(center + horizon)
              #counter(page).display( "1")
            ]
        ]
      ]
    },
    background: rect(fill: rgb("#888"))[ 
      #place(top + left)[
        #image("wave.svg", width: 70%, height: 20%)]
      #place(bottom + right)[
        #rotate(180deg, image("wave.svg", width: 70%, height: 20%))
    ]
    ],
  )

  show link: it => {
    set text(blue)
    if type(it.dest) != str {
      it
    }
    else {
      underline(it)
    }
  }

  show figure: set block(breakable: true)


  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)


  if title != none {
    align(center + horizon)[#block(inset: 1em)[
      #text(
        font: "Clash Display Variable",
        size: 2.5em,
        fill: rgb("#106BA0")
        )[#title]
    ]]
  }

  if institutions != none {
    v(2%)
    // align(center)[
    //         #image("logo.svg", width: 30em, height: 30em, fit: "contain")
    //       ]
    let count = institutions.len()
    let ncols = calc.min(count, 5)
    v(8%)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..institutions.map(institution =>
          align(center)[
            #image(institution.logo, width: 5em, height: 5em, fit: "contain")
          ]
      )
    )
    pagebreak()
  }

// silhouette.double
// silhouette.speak

  show heading.where( level: 1): it => [
    // #set align(center)
    #set text(
      font: "Clash Display Variable",
      size: 1.8em,
      fill: rgb("#AEC800"),
    )
    #block(it.body)
  ]
  show heading.where( level: 2): it => [
    #set text(
      font: "Clash Display Variable",
      size: 1.5em,
      fill: rgb("#AEC800"),
    )
    #block(it.body)
  ]
  show heading.where( level: 3): it => [
    // #pagebreak()
    #set text(
      font: "Clash Display Variable",
      size: 1.3em,
      fill: rgb("#DEFF00"),
      )
    #block(it.body)
  ]

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }

  if toc {
    block(above: 0em, below: 2em)[
    #outline(
      title: auto,
      depth: none
    );
    ]
  }

  if cols == 1 {
    block(inset: 5em, doc)
    
  } else {
    columns(cols, doc)
  }
}
