open ReactNative

/**
 * The order is important
 * */
let keys = {
  open Key

  [
    Operation(AC),
    Operation(PlusMine),
    Operation(Modulo),
    Operation(Divide),
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
  let (appReady, setAppReady) = React.useState(() => false)

  Tw.useDeviceContext(
    Tw.customTwInstance,
    ~options={
      withDeviceColorScheme: false,
    },
    (),
  )

  let (colorScheme, _, setColorScheme) = Tw.useAppColorScheme(Tw.customTwInstance, ())

  React.useEffect1(() => {
    ReactNativeAsyncStorage.setItem("colorScheme", colorScheme->Obj.magic)->ignore

    None
  }, [colorScheme])

  React.useLayoutEffect0(() => {
    ReactNativeAsyncStorage.getItem("colorScheme")
    ->Promise.Js.toResult
    ->Promise.tapOk(colorScheme => {
      setColorScheme(colorScheme->Js.Null.toOption->Option.mapWithDefault(#light, Obj.magic))

      setAppReady(_ => true)
    })
    ->Promise.tapError(_ => {
      setColorScheme(#light)
      setAppReady(_ => true)
    })
    ->ignore

    None
  })

  if appReady {
    <View style={Tw.style("bg-white dark:bg-gray-800 flex-1")}>
      <Expo.StatusBar style="auto" />
      <DarkModeToggler setColorScheme />
      <CountDisplay />
      <View
        style={Tw.style(
          "flex-1 flex-wrap flex-row bg-gray-50 dark:bg-gray-700 rounded-t-[40px] pt-10 px-4 justify-center items-center",
        )}>
        {keys->Array.map(value => <Key key={value->Key.toString} value />)->React.array}
      </View>
    </View>
  } else {
    <Expo.AppLoading />
  }
}

let default = make
