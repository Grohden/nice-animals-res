open Promise

module Response = {
  type t<'data>
  @send external json: t<'data> => Promise.t<'data> = "json"
}

module ShibeOnline = {
  type response = array<string>

  @val @scope("globalThis")
  external fetch: string => Promise.t<Response.t<array<string>>> = "fetch"

  let argToStr = ((name, value)) => name ++ "=" ++ value

  let toQueryStr = list => Belt.Array.joinWith(list, "&", argToStr)

  let getAnimals = (~count=10, ~urls=true, ()) => {
    let queryStr = [("count", count->Js.Int.toString), ("urls", urls->Js.String.make)]->toQueryStr

    fetch("https://shibe.online/api/shibes?" ++ queryStr)->then(Response.json)
  }
}
