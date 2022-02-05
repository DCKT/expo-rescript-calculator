module SafeAreaProvider = {
  @module("react-native-safe-area-context") @react.component
  external make: (~children: React.element, ~style: ReactNative.Style.t=?) => React.element =
    "SafeAreaProvider"
}
module SafeAreaView = {
  @module("react-native-safe-area-context") @react.component
  external make: (~children: React.element, ~style: ReactNative.Style.t=?) => React.element =
    "SafeAreaView"
}

type insets = {
  top: float,
  bottom: float,
  right: float,
  left: float,
}

@module("react-native-safe-area-context")
external useSafeAreaInsets: unit => insets = "useSafeAreaInsets"
