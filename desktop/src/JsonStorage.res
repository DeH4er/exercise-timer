open Promise

let getPath: string => string = key => {
  Node.Path.resolve([Electron.App.getPath(#userData), `${key}.json`])
}

let set: ('a, string) => Promise.t<result<unit, Node.Fs.err>> = (json, key) => {
  json->Shared.Utils.stringify->Node.Fs.writeFile(key->getPath)
}

let get: string => Promise.t<result<'a, Node.Fs.err>> = key => {
  Node.Fs.readFile(key->getPath)->then(res => {
    res->Belt.Result.map(Shared.Utils.parse)->resolve
  })
}
