open ReactNative

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

let toString = (t: t) => {
  switch t {
  | Operation(Add) => "+"
  | Operation(Divide) => "/"
  | Operation(Multiply) => "x"
  | Operation(Substract) => "-"
  | Operation(Equal) => "="
  | Operation(AC) => "AC"
  | Operation(PlusMine) => "+/-"
  | Operation(Modulo) => "%"
  | Operation(Undo) => "<-"
  | Operation(Period) => "."
  | Number(n) => n->Int.toString
  }
}

let toElement = (t: t) => {
  switch t {
  | Operation(Add) => <Expo.Icons.FontAwesome5 name="plus" size={24} />
  | Operation(Divide) => <Expo.Icons.FontAwesome5 name="divide" size={24} />
  | Operation(Multiply) => <Expo.Icons.FontAwesome name="remove" size={24} />
  | Operation(Substract) => <Expo.Icons.FontAwesome5 name="minus" size={24} />
  | Operation(Equal) => <Expo.Icons.FontAwesome5 name="equals" size={24} />
  | Operation(AC) => "AC"->React.string
  | Operation(PlusMine) => "+/-"->React.string
  | Operation(Modulo) => <Expo.Icons.FontAwesome5 name="percent" size={24} />
  | Operation(Undo) => <Expo.Icons.FontAwesome5 name="undo" size={24} />
  | Operation(Period) => "."->React.string
  | Number(n) => n->React.int
  }
}

@react.component
let make = (~value: t) => {
  <TouchableOpacity
    style={Tw.style(
      "flex-initial w-16 h-16 bg-gray-100 dark:bg-gray-600 justify-center items-center rounded-xl m-3",
    )}>
    <Text
      style={Tw.styleArray([
        "font-bold",
        switch value {
        | Operation(Add)
        | Operation(Divide)
        | Operation(Multiply)
        | Operation(Substract)
        | Operation(Equal) => "text-red-400"
        | Operation(AC)
        | Operation(PlusMine)
        | Operation(Modulo) => "text-2xl font-bold text-green-400"
        | Operation(Undo)
        | Operation(Period)
        | Number(_) => "text-gray-800 dark:text-gray-200 text-2xl"
        },
      ])}>
      {value->toElement}
    </Text>
  </TouchableOpacity>
}
