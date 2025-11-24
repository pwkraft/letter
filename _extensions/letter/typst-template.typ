// This function gets your whole document as its `body`
// and formats it as a simple letter.

#let letter(
  margin: (x: 2cm, y: 2cm, top: 3.5cm, bottom: 4.5cm),
  paper: "a4",
  lang: "en",
  region: "AU",
  font: "libertinus serif",
  fontsize: 11pt,
  linestretch: 1.3,
  pagenumbering: "1",
  qualifications: none,
  position: none,
  www: none,
  email: none,
  phone: none,
  department: "Institute of Public Goods and Policies (IPP)",
  university: "Spanish National Research Council (CSIC)",
  ps: none,
  opening: "To whom it may concern",
  closing: "Yours sincerely",
  sig: "",
  // The letter's recipient, which is displayed close to the top.
  recipient: none,

  // The date, displayed to the right.
  date: none,

  // The subject line.
  subject: none,

  // The name with which the letter closes.
  author: "",

  // The letter's content.
  body
) = {
  // Configure page and text properties - normal margins for all pages
  set page(
    paper: paper,
    margin: margin,
    // Remove default numbering and use custom footer instead
    header: context {
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [
          #image("csic.png", height: 1cm)
        ],
        [
          #image("ipp.png", height: 1cm)
        ]
      )
    },
    footer: context {
      let page-num = here().page()
      grid(
        columns: (auto, 1fr),
        align: (left, right),
        gutter: 0pt,
        [
          #set text(font: "fira sans", fill: rgb(100,100,100), size: 9pt)
          #set par(leading: 0.6em)
          #strong(author)#if(qualifications != none) [, #qualifications] \
          #if(position != none) [
            #position \
          ]
          #if (department != none) [
            #department \
          ]
          #if(university != none) [
            #university \
          ]
          #v(1pt)
          #if(email != none or phone != none or www != none) [
            #let contact-items = ()
            #if(email != none) {
              contact-items.push([#text(font: "Font Awesome 6 Free", size: 8pt, "\u{f0e0}") #email.replace("\\@", "@")])
            }
            #if(phone != none) {
              contact-items.push([#text(font: "Font Awesome 6 Free", size: 8pt, "\u{f095}") #phone])
            }
            #if(www != none) {
              contact-items.push([#text(font: "Font Awesome 6 Free", size: 8pt, "\u{f015}") #www])
            }
            #contact-items.join([#h(10pt)])
          ]
        ],
        [
          #v(24pt)
          #align(right, str(page-num))
          #image("europe_age_csic_ipp.png", height: 0.7cm)
        ]
      )
      if page-num > 1 {
        v(1.7cm)  // Push page number 1cm lower
        // align(center, str(page-num))
      }
    }
  )

  set par(
    justify: true,
    leading: linestretch * 0.7em,
    spacing: linestretch * 1.3em
  )
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set text(font: "libertinus serif", size: 11pt)

  // Make all links blue
  show link: set text(fill: rgb(0, 0, 255))

  // Place footer content on first page only
  // place(
  //   bottom + right,
  //   dx: -0.1cm,
  //   dy: 3.75cm,
  //   context {
  //     // if here().page() == 1 {
  //       image("europe_age_csic_ipp.png", height: 0.8cm)
  //     //}
  //   }
  // )

  // Display sender at bottom left of first page only
  // place(
  //   bottom + left,
  //   dx: -0.8cm,
  //   dy: 3.5cm,
  //   context {
  //     // if here().page() == 1 {
  //       block[
  //         #set text(font: "fira sans", fill: rgb(100,100,100), size: 9pt)
  //         #set par(leading: 0.6em)
  //         #strong(author)#if(qualifications != none) [, #qualifications] \
  //         #if(position != none) [
  //           #position \
  //         ]
  //         #if (department != none) [
  //           #department \
  //         ]
  //         #if(university != none) [
  //           #university \
  //         ]
  //         #v(1pt)
  //         #if(email != none or phone != none or www != none) [
  //           #let contact-items = ()
  //           #if(email != none) {
  //             contact-items.push([#text(font: "Font Awesome 6 Free", size: 8pt, "\u{f0e0}") #email.replace("\\@", "@")])
  //           }
  //           #if(phone != none) {
  //             contact-items.push([#text(font: "Font Awesome 6 Free", size: 8pt, "\u{f095}") #phone])
  //           }
  //           #if(www != none) {
  //             contact-items.push([#text(font: "Font Awesome 6 Free", size: 8pt, "\u{f015}") #www])
  //           }
  //           #contact-items.join([#h(10pt)])
  //         ]
  //       ]
  //     // }
  //   }
  // )

  // v(-16pt)
  // grid(
  //     columns: (1fr, 1fr),
  //     align: (left, right),
  //     [
  //       #image("csic.png", height: 1cm)
  //     ],
  //     [
  //       #image("ipp.png", height: 1cm)
  //     ]
  // )
  // v(25pt)

  // Display date. If there's no date add some hidden
  // text to keep the same spacing.
  align(right, if date != none {
    date
  } else {
    hide("a")
  })

  v(0.25cm)

  // Display recipient
  if recipient != none {
    block[
      #set par(leading: 0.6em)
      #recipient
    ]
  }

  v(0.5cm)

  // Add the subject line, if any.
  if subject != none {
    pad(right: 10%, strong(subject))
    v(0.2cm)
  }

  // Add opening salutation
  if opening != none {
    opening
  }

  // Add body and name.
  body

  v(0.2cm)

  closing

  if(sig != "" and sig != none) {
    v(-0.2cm)
    pad(left: 0.5cm, bottom: -0.5cm)[
      #let sig-path = if type(sig) == content {
        repr(sig).slice(1, -1) // Remove quotes from repr
      } else {
        sig
      }
      #image(sig-path, height: 1.5cm)
    ]
  } else {
    v(1cm)
  }
  if ps != none {
    v(1cm)
    ps
  }
}
