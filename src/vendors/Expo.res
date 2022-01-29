module Icons = {
  module FontAwesome = {
    @module("@expo/vector-icons") @react.component
    external make: (~name: string, ~size: int, ~color: string=?) => React.element = "FontAwesome"
  }
  module FontAwesome5 = {
    @module("@expo/vector-icons") @react.component
    external make: (~name: string, ~size: int, ~color: string=?) => React.element = "FontAwesome5"
  }
  module Feather = {
    @module("@expo/vector-icons") @react.component
    external make: (~name: string, ~size: int, ~color: string=?) => React.element = "Feather"
  }
}

module StatusBar = {
  @module("expo-status-bar") @react.component
  external make: (~style: string) => React.element = "StatusBar"
}

module AppLoading = {
  @module("expo-app-loading") @react.component
  external make: unit => React.element = "default"
}
