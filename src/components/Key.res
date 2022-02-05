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
  | Operation(Calcul(Add)) => <Expo.Icons.FontAwesome5 name="plus" size={24} />
  | Operation(Calcul(Divide)) => <Expo.Icons.FontAwesome5 name="divide" size={24} />
  | Operation(Calcul(Multiply)) => <Expo.Icons.FontAwesome name="remove" size={24} />
  | Operation(Calcul(Substract)) => <Expo.Icons.FontAwesome5 name="minus" size={24} />
  | Operation(Action(Equal)) => <Expo.Icons.FontAwesome5 name="equals" size={24} />
  | Operation(Action(AC)) => "AC"->React.string
  | Operation(Action(PlusMine)) => "+/-"->React.string
  | Operation(Calcul(Modulo)) => <Expo.Icons.FontAwesome5 name="percent" size={24} />
  | Operation(Action(Undo)) => <Expo.Icons.FontAwesome5 name="undo" size={24} />
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
      isActive ? "bg-gray-200 dark:bg-gray-600" : "bg-gray-100 dark:bg-gray-600",
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
        | Operation(Calcul(Modulo)) => "text-2xl font-bold text-green-400"
        | Operation(Action(Undo))
        | Operation(Action(Period))
        | Number(_) => "text-gray-800 dark:text-gray-200 text-2xl"
        },
      ])}>
      {value->toElement}
    </Text>
  </TouchableOpacity>
}

let calculate = (entries: array<t>) => {
  let (_, total) = entries->Array.reduce((None, 0.), (acc, entry) => {
    let (previous, total) = acc

    switch (previous, entry) {
    | (None, _) => (Some(entry), total)
    | (Some(Number(_)), Number(_)) => acc
    | (Some(Number(v)), Operation(_)) => (Some(entry), v)
    | (Some(Operation(Calcul(operator))), Number(v)) => {
        let newTotal = switch operator {
        | Add => total +. v
        | Substract => total -. v
        | Multiply => total *. v
        | Divide => total /. v
        | Modulo => mod(total->Int.fromFloat, v->Int.fromFloat)->Float.fromInt
        }
        (Some(Number(newTotal)), newTotal)
      }
    | (Some(Operation(Action(action))), Number(v)) =>
      switch action {
      | Period => {
          let concatenatedValue =
            (total->Float.toString ++ "." ++ v->Float.toString)->Js.Float.fromString

          (Some(Number(concatenatedValue)), concatenatedValue)
        }
      | _ => acc
      }
    | (Some(Operation(_)), Operation(_)) => acc
    }
  })

  total
}