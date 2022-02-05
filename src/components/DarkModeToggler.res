open ReactNative

@react.component
let make = (~setColorScheme) => {
  let insets = ReactNativeSafeAreaContext.useSafeAreaInsets()

  <View
    style={Style.array([
      Tw.style(
        "flex-initial flex-grow-0 self-center flex-row items-center bg-gray-200 dark:bg-gray-700 rounded-xl z-10",
      ),
      Style.viewStyle(~marginTop=insets.top->Style.dp, ()),
    ])}>
    <TouchableOpacity
      style={Tw.style("flex-initial w-14 h-14 rounded-l-lg justify-center items-center ")}
      onPress={_ => setColorScheme(#light)}>
      <Text style={Tw.style("text-gray-800 dark:text-gray-900")}>
        <Expo.Icons.Feather name="sun" size={20} />
      </Text>
    </TouchableOpacity>
    <TouchableOpacity
      style={Tw.style("flex-initial w-14 h-14 rounded-l-lg justify-center items-center ")}
      onPress={_ => setColorScheme(#dark)}>
      <Text style={Tw.style("text-gray-400 dark:text-white")}>
        <Expo.Icons.Feather name="moon" size={20} />
      </Text>
    </TouchableOpacity>
  </View>
}
