open ReactNative

@react.component
let make = () => {
  <View style={Tw.style("flex-initial h-64 items-end justify-end p-6")}>
    <View style={Tw.style("flex-initial items-end")}>
      <Text style={Tw.style("text-xl text-gray-700 dark:text-gray-200")}>
        {"200 x 200"->React.string}
      </Text>
      <Text style={Tw.style("mt-2 text-4xl text-gray-700 dark:text-gray-100 font-bold")}>
        {250000->React.int}
      </Text>
    </View>
  </View>
}
