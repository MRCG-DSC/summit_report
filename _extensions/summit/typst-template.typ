
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

#let article(
  title: none,
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
  margin: (x: 2.5cm, y: 5cm),
  paper: "a4",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
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
    paper: paper,
    margin: margin,
    // header-ascent: -2cm,
    // header: rect(fill: aqua.lighten(50%))[ #place(top + left)[
    // #image("wave.svg", width: 100%, height: 100%)]],
    // footer: [ #place(bottom + right)[
    //   #rotate(180deg, 
    //   image("wave.svg", width: 70%, height: 100%))
    // ]],
    background: rect(fill: aqua.darken(50%))[ 
      #place(top + left)[
        #image("wave.svg", width: 70%, height: 20%)]
      #place(bottom + right)[
        #rotate(180deg, image("wave.svg", width: 70%, height: 20%))
    ]
    ],
    // number-align: center,
    // numbering: "1",
  )

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
        weight: "bold", size: 2.2em
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

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

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
    doc
  } else {
    columns(cols, doc)
  }
}
