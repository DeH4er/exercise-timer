open Promise

let getPath: string => string = key => {
  Node.Path.resolve([Electron.App.getPath(#userData), `${key}.json`])
}

let set: ('a, string, 'a => string) => Promise.t<result<unit, Node.Fs.err>> = (
  json,
  key,
  stringify,
) => {
  json->stringify->Node.Fs.writeFile(key->getPath)
}

let get: (string, string => option<'a>) => Promise.t<result<'a, Node.Fs.err>> = (key, parse) => {
  Node.Fs.readFile(key->getPath)->then(res => {
    res
    ->Belt.Result.flatMap(str => {
      switch parse(str) {
      | Some(obj) => obj->Ok
      | None => Error(Unknown)
      }
    })
    ->resolve
  })
}
