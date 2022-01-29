open ReactNative

module StatusBar = {
  @module("expo-status-bar") @react.component
  external make: (~style: string) => React.element = "StatusBar"
}

let styles = {
  open Style

  StyleSheet.create({
    "container": viewStyle(
      ~flex=1.,
      ~backgroundColor="#fff",
      ~alignItems=#center,
      ~justifyContent=#center,
      (),
    ),
  })
}

module CountDisplay = {
  @react.component
  let make = () => {
    <View style={Tw.style("flex-initial h-64 items-end justify-end p-6")}>
      <View style={Tw.style("flex-initial items-end")}>
        <Text style={Tw.style("text-xl")}> {"200 x 200"->React.string} </Text>
        <Text style={Tw.style("mt-2 text-4xl text-gray-700 dark:text-gray-200 font-bold")}>
          {250000->React.int}
        </Text>
      </View>
    </View>
  }
}

module Keyboard = {
  @react.component
  let make = (~children) => {
    <View
      style={Tw.style(
        "flex-1 flex-wrap flex-row bg-gray-50 dark:bg-gray-700 rounded-t-[40px] pt-10 px-4 justify-center items-center",
      )}>
      children
    </View>
  }
}

module Key = {
  type rec t =
    | Operation(operator)
    | Number(int)

  and operator =
    | Add
    | Substract
    | Multiply
    | Fraction
    | Equal
    | AC
    | PlusMine
    | Modulo
    | Undo
    | Period

  let toString = (t: t) => {
    switch t {
    | Operation(Add) => "+"
    | Operation(Fraction) => "/"
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

  @react.component
  let make = (~value: t) => {
    <TouchableOpacity
      style={Tw.style(
        "flex-initial w-16 h-16 bg-gray-100 dark:bg-gray-600 justify-center items-center rounded-xl m-3",
      )}>
      <Text
        style={Tw.styleArray([
          "text-xl font-semibold",
          switch value {
          | Operation(Add)
          | Operation(Fraction)
          | Operation(Multiply)
          | Operation(Substract)
          | Operation(Equal) => "text-red-400"
          | Operation(AC)
          | Operation(PlusMine)
          | Operation(Modulo) => "text-green-400"
          | Operation(Undo)
          | Operation(Period)
          | Number(_) => "text-gray-800 dark:text-gray-200"
          },
        ])}>
        {value->toString->React.string}
      </Text>
    </TouchableOpacity>
  }
}

let keys = {
  open Key

  [
    Operation(AC),
    Operation(PlusMine),
    Operation(Modulo),
    Operation(Fraction),
    Number(7),
    Number(8),
    Number(9),
    Operation(Multiply),
    Number(4),
    Number(5),
    Number(6),
    Operation(Substract),
    Number(1),
    Number(2),
    Number(3),
    Operation(Add),
    Operation(Undo),
    Number(0),
    Operation(Period),
    Operation(Equal),
  ]
}

@react.component
let make = () => {
  Tw.useDeviceContext(Tw.tw)

  <View style={Tw.style("bg-white dark:bg-gray-800 flex-1")}>
    <StatusBar style="auto" />
    <CountDisplay />
    <Keyboard>
      {keys->Array.map(value => <Key key={value->Key.toString} value />)->React.array}
    </Keyboard>
  </View>
}

let default = make
