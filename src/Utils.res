@val
external eval: 'a => 'b = "eval"

let calculate = (entries: array<Key.t>) => {
  entries
  ->Array.map(entry =>
    switch entry {
    | Calcul(Add) => "+"
    | Calcul(Divide) => "/"
    | Calcul(Multiply) => "*"
    | Calcul(Substract) => "-"
    | Calcul(Modulo) => "%"
    | Number(n) => n->Float.toString
    | _ => ""
    }
  )
  ->Js.Array2.joinWith("")
  ->eval
}
