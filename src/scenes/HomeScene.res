open ReactNative
open ShibeOnline

let styles = {
  open Style
  StyleSheet.create({
    "imageContainer": viewStyle(~justifyContent=#center, ~padding=12.->dp, ()),
  })
}

let toSource = uri => {
  open Image
  Source.fromUriSource(uriSource(~uri, ()))
}

module HomeScene = {
  type state = Loading | Loaded(array<string>)

  @react.component
  let make = () => {
    let (state, setState) = React.Uncurried.useState(_ => Loading)
    let dimensions = Dimensions.get(#screen)
    let imageSize = Style.dp(dimensions.width -. 24.)

    React.useEffect0(() => {
      open Promise
      ShibeOnline.getAnimals()
      ->then(urls => {
        setState(._prev => Loaded(urls))
        resolve()
      })
      ->ignore

      None
    })

    switch state {
    | Loading => <ActivityIndicator />
    | Loaded(urls) =>
      urls
      ->Belt.Array.map(url => {
        <View key={url} style={styles["imageContainer"]}>
          <Image
            source={toSource(url)}
            style={
              open Style
              style(~maxWidth=imageSize, ~height=imageSize, ())
            }
          />
        </View>
      })
      ->React.array
    }
  }
}
