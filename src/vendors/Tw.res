type twInstance

@module("twrnc")
external create: 'a => twInstance = "create"

@module("../../tailwind.config.js")
external tailwindConfig: 'a = "default"

let customTwInstance = create(tailwindConfig)

@module("twrnc")
external tw: twInstance = "default"

@send
external _style: (twInstance, string) => ReactNative.Style.t = "style"
@send
external _styleArray: (twInstance, array<string>) => ReactNative.Style.t = "style"

let style = str => _style(customTwInstance, str)
let styleArray = str => _styleArray(customTwInstance, str)

@module("twrnc") @scope("default")
external styleObject: Js.t<'a> => ReactNative.Style.t = "style"

type deviceContextOptions = {withDeviceColorScheme: bool}

@module("twrnc")
external useDeviceContext: (twInstance, ~options: deviceContextOptions=?, unit) => unit =
  "useDeviceContext"

type colorScheme = [
  | #light
  | #dark
]

@module("twrnc")
external useAppColorScheme: (
  twInstance,
  ~initialValue: colorScheme=?,
  unit,
) => (colorScheme, unit => unit, (colorScheme => colorScheme) => unit) = "useAppColorScheme"
