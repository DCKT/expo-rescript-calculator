@val
external eval: 'a => 'b = "eval"

let calculate = (entries: array<Key.t>) => {
  entries
  ->Array.map(entry =>
    switch entry {
    | Operation(Calcul(Add)) => "+"
    | Operation(Calcul(Divide)) => "/"
    | Operation(Calcul(Multiply)) => "*"
    | Operation(Calcul(Substract)) => "-"
    | Operation(Calcul(Modulo)) => "%"
    | Number(n) => n->Float.toString
    | _ => ""
    }
  )
  ->Js.Array2.joinWith("")
  ->eval
}
