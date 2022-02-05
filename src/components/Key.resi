type rec t =
  | Operation(operation)
  | Number(float)

and operation =
  | Calcul(operator)
  | Action(action)
and operator =
  | Add
  | Substract
  | Multiply
  | Divide
  | Modulo
and action =
  | Equal
  | AC
  | PlusMine
  | Undo
  | Period

let toString: t => string

@react.component
let make: (~value: t, ~onPress: unit => unit, ~isActive: bool) => React.element
