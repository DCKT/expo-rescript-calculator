open ReactNative

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

let toString = (t: t) => {
  switch t {
  | Operation(Calcul(Add)) => "+"
  | Operation(Calcul(Divide)) => "/"
  | Operation(Calcul(Multiply)) => "x"
  | Operation(Calcul(Substract)) => "-"
  | Operation(Action(Equal)) => "="
  | Operation(Action(AC)) => "AC"
  | Operation(Action(PlusMine)) => "+/-"
  | Operation(Calcul(Modulo)) => "%"
  | Operation(Action(Undo)) => "<-"
  | Operation(Action(Period)) => "."
  | Number(n) => n->Float.toString
  }
}

let toElement = (t: t) => {
  switch t {
  | Operation(Calcul(Add)) => <Expo.Icons.FontAwesome5 name="plus" size={26} />
  | Operation(Calcul(Divide)) => <Expo.Icons.FontAwesome5 name="divide" size={26} />
  | Operation(Calcul(Multiply)) => <Expo.Icons.FontAwesome name="remove" size={26} />
  | Operation(Calcul(Substract)) => <Expo.Icons.FontAwesome5 name="minus" size={26} />
  | Operation(Action(Equal)) => <Expo.Icons.FontAwesome5 name="equals" size={26} />
  | Operation(Action(AC)) => "AC"->React.string
  | Operation(Action(PlusMine)) => "+/-"->React.string
  | Operation(Calcul(Modulo)) => <Expo.Icons.FontAwesome5 name="percent" size={26} />
  | Operation(Action(Undo)) => <Expo.Icons.FontAwesome5 name="undo" size={26} />
  | Operation(Action(Period)) => "."->React.string
  | Number(n) => n->React.float
  }
}

@react.component
let make = (~value: t, ~onPress, ~isActive) => {
  <TouchableOpacity
    onPress={_ => onPress()}
    style={Tw.styleArray([
      "flex-initial w-16 h-16 justify-center items-center rounded-xl m-3",
      isActive ? "bg-gray-300 dark:bg-gray-400" : "bg-gray-200 dark:bg-gray-600",
    ])}>
    <Text
      style={Tw.styleArray([
        "font-bold",
        switch value {
        | Operation(Calcul(Add))
        | Operation(Calcul(Divide))
        | Operation(Calcul(Multiply))
        | Operation(Calcul(Substract))
        | Operation(Action(Equal)) => "text-red-400"
        | Operation(Action(AC))
        | Operation(Action(PlusMine))
        | Operation(Calcul(Modulo)) => "text-3xl font-bold text-green-400"
        | Operation(Action(Undo))
        | Operation(Action(Period))
        | Number(_) => "text-gray-800 dark:text-gray-200 text-3xl"
        },
      ])}>
      {value->toElement}
    </Text>
  </TouchableOpacity>
}
