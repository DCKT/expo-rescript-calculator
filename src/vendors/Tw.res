type twInstance

@module("twrnc")
external tw: twInstance = "default"

@module("twrnc") @scope("default")
external style: string => ReactNative.Style.t = "style"

@module("twrnc") @scope("default")
external styleArray: array<string> => ReactNative.Style.t = "style"

@module("twrnc") @scope("default")
external styleObject: Js.t<'a> => ReactNative.Style.t = "style"

@module("twrnc")
external useDeviceContext: twInstance => unit = "useDeviceContext"
