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

  <> <StatusBar barStyle={isDarkMode ? #lightContent : #darkContent} /> <HomeScene /> </>
}
