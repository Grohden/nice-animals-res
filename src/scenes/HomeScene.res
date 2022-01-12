open ReactNative
open ShibeOnline

let styles = {
  open Style
  StyleSheet.create({
    "mainContainer": viewStyle(~flex=1., ()),
    "imageContainer": viewStyle(~justifyContent=#center, ()),
  })
}

let toSource = uri => {
  open Image
  Source.fromUriSource(uriSource(~uri, ()))
}

type state = Loading | Loaded(array<string>)

@react.component
let make = () => {
  let (state, setState) = React.Uncurried.useState(_ => Loading)
  let dimensions = Dimensions.get(#window)
  let numColumns = 2
  let imageSize = (dimensions.width /. Belt.Float.fromInt(numColumns))->Style.dp

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
    <FlatList
      style={styles["mainContainer"]}
      contentInsetAdjustmentBehavior=#automatic
      data={urls}
      numColumns={numColumns}
      extraData={styles["imageContainer"]}
      keyExtractor={(url, _) => url}
      renderItem={data => {
        <View style={styles["imageContainer"]}>
          <Image
            source={toSource(data.item)}
            style={
              open Style
              style(~width=imageSize, ~height=imageSize, ())
            }
          />
        </View>
      }}
    />
  }
}
