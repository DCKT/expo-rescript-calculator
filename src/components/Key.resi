type rec t =
  | Calcul(operator)
  | Action(action)
  | Number(float)

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
  | Period

let toString: t => string

@react.component
let make: (~value: t, ~onPress: unit => unit, ~isActive: bool) => React.element
