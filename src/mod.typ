#import "/src/book.typ"
#import "/typ/templates/page.typ"

#let exec-code(cc, res: none, scope: (:), eval: eval) = {
  // Don't corrupt normal headings
  set heading(outlined: false)

  rect(width: 100%, inset: 10pt, if res != none {
    res
  } else {
    eval(cc.text, mode: "markup", scope: scope)
  })
}

#let code(cc, show-cc: true, res: none, scope: (:), eval: eval, exec-code: exec-code) = {
  if show-cc {
    cc
  }
  exec-code(cc, res: res, scope: scope, eval: eval)
}
