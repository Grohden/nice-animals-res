open ReactNative
open HomeScene

let useIsDarkMode = () => {
  Appearance.useColorScheme()
  ->Js.Null.toOption
  ->Belt.Option.map(scheme => scheme === #dark)
  ->Belt.Option.getWithDefault(false)
}

@react.component
let app = () => {
  let isDarkMode = useIsDarkMode()

  <SafeAreaView>
    <StatusBar barStyle={isDarkMode ? #lightContent : #darkContent} />
    <ScrollView contentInsetAdjustmentBehavior=#automatic> <HomeScene /> </ScrollView>
  </SafeAreaView>
}
