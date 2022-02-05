open ReactNative

LogBox.ignoreAllLogs()

/**
 * The order is important
 * */
let keys = {
  open Key

  [
    Operation(Action(AC)),
    Operation(Action(PlusMine)),
    Operation(Calcul(Modulo)),
    Operation(Calcul(Divide)),
    Number(7.),
    Number(8.),
    Number(9.),
    Operation(Calcul(Multiply)),
    Number(4.),
    Number(5.),
    Number(6.),
    Operation(Calcul(Substract)),
    Number(1.),
    Number(2.),
    Number(3.),
    Operation(Calcul(Add)),
    Operation(Action(Undo)),
    Number(0.),
    Operation(Action(Period)),
    Operation(Action(Equal)),
  ]
}

type state = {
  entriesTmp: array<Key.t>,
  upperline: string,
  currentInput: Key.t,
  result: float,
}

type action = ProcessKey(Key.t)

let initialState = {entriesTmp: [], upperline: "", currentInput: Key.Number(0.), result: 0.}

@react.component
let make = () => {
  let (appReady, setAppReady) = React.useState(() => false)

  let (state, dispatch) = React.useReducer((state, action) => {
    let {currentInput, entriesTmp} = state

    switch (action, currentInput) {
    | (ProcessKey(Operation(Action(AC))), _) => initialState
    | (ProcessKey(Number(n1)), Number(n2)) => {
        let concatenatedValue =
          n2 === 0. ? n1 : (n2->Float.toString ++ n1->Float.toString)->Js.Float.fromString
        {
          ...state,
          currentInput: Number(concatenatedValue),
          result: concatenatedValue,
        }
      }
    // | (ProcessKey(Number(n1)), Operation(Action(Period))) => {
    //     let concatenatedValue = entriesTmp->Js.Array2.slice(-1) (n2->Float.toString ++ n1->Float.toString)->Js.Float.fromString
    //     {
    //       ...state,
    //       currentInput: Number(concatenatedValue),
    //       result: concatenatedValue,
    //     }
    //   }
    // | (ProcessKey(Operation(Action(Period)) as input), Number(_)) => {
    //     ...state,
    //     entriesTmp: entriesTmp->Array.concat([currentInput]),
    //     currentInput: input,
    //   }
    | (ProcessKey(Operation(Calcul(_) as input)), Number(_)) => {
        ...state,
        entriesTmp: entriesTmp->Array.concat([currentInput]),
        currentInput: Operation(input),
      }
    | (ProcessKey(Number(v1) as input), Operation(Action(Equal))) => {
        entriesTmp: [],
        upperline: "",
        currentInput: input,
        result: v1,
      }
    | (ProcessKey(Number(v1) as input), Operation(Calcul(_))) => {
        let updatedEntries = entriesTmp->Array.concat([currentInput])

        {
          entriesTmp: updatedEntries,
          upperline: updatedEntries->Array.map(Key.toString)->Js.Array2.joinWith(" "),
          currentInput: input,
          result: v1,
        }
      }
    | (ProcessKey(Operation(Action(Equal)) as input), Number(value)) => {
        let updatedEntries = entriesTmp->Array.concat([Number(value)])

        {
          entriesTmp: updatedEntries,
          upperline: updatedEntries->Array.map(Key.toString)->Js.Array2.joinWith(" "),
          currentInput: input,
          result: Utils.calculate(updatedEntries),
        }
      }
    | _ => state
    }
  }, initialState)

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
      <CountDisplay result=state.result upperline={state.upperline} />
      <View
        style={Tw.style(
          "flex-1 flex-wrap flex-row bg-gray-50 dark:bg-gray-700 rounded-t-[40px] pt-10 px-4 justify-center items-center",
        )}>
        {keys
        ->Array.map(value =>
          <Key
            key={value->Key.toString}
            value
            isActive={switch (value, state.currentInput) {
            | (Operation(Calcul(op1)), Operation(Calcul(op2))) if op1 === op2 => true
            | _ => false
            }}
            onPress={_ => {
              dispatch(ProcessKey(value))
              ()
            }}
          />
        )
        ->React.array}
      </View>
    </View>
  } else {
    <Expo.AppLoading />
  }
}

let default = make
