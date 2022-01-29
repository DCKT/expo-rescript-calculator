type rec t =
  | Operation(operator)
  | Number(int)

and operator =
  | Add
  | Substract
  | Multiply
  | Divide
  | Equal
  | AC
  | PlusMine
  | Modulo
  | Undo
  | Period

let toString: t => string

@react.component
let make: (~value: t) => React.element
