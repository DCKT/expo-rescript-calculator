open ReactNative

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

let toString = (t: t) => {
  switch t {
  | Calcul(Add) => "+"
  | Calcul(Divide) => "/"
  | Calcul(Multiply) => "x"
  | Calcul(Substract) => "-"
  | Action(Equal) => "="
  | Action(AC) => "AC"
  | Action(PlusMine) => "+/-"
  | Calcul(Modulo) => "%"
  | Action(Period) => "."
  | Number(n) => n->Float.toString
  }
}

let toElement = (t: t) => {
  switch t {
  | Calcul(Add) => <Expo.Icons.FontAwesome5 name="plus" size={26} />
  | Calcul(Divide) => <Expo.Icons.FontAwesome5 name="divide" size={26} />
  | Calcul(Multiply) => <Expo.Icons.FontAwesome name="remove" size={26} />
  | Calcul(Substract) => <Expo.Icons.FontAwesome5 name="minus" size={26} />
  | Action(Equal) => <Expo.Icons.FontAwesome5 name="equals" size={26} />
  | Action(AC) => "AC"->React.string
  | Action(PlusMine) => "+/-"->React.string
  | Calcul(Modulo) => <Expo.Icons.FontAwesome5 name="percent" size={26} />
  | Action(Period) => "."->React.string
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
      switch value {
      | Number(0.) => "w-38"
      | _ => ""
      },
    ])}>
    <Text
      style={Tw.styleArray([
        "font-bold",
        switch value {
        | Calcul(Add)
        | Calcul(Divide)
        | Calcul(Multiply)
        | Calcul(Substract)
        | Action(Equal) => "text-red-400"
        | Action(AC)
        | Action(PlusMine)
        | Calcul(Modulo) => "text-3xl font-bold text-green-400"
        | Action(Period)
        | Number(_) => "text-gray-800 dark:text-gray-200 text-3xl"
        },
      ])}>
      {value->toElement}
    </Text>
  </TouchableOpacity>
}
