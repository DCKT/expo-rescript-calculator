@module("@react-native-async-storage/async-storage") @scope("default")
external setItem: (string, string) => Promise.Js.t<unit, 'err> = "setItem"

@module("@react-native-async-storage/async-storage") @scope("default")
external getItem: string => Promise.Js.t<Js.Null.t<string>, 'err> = "getItem"
