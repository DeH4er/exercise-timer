open Promise

@val
external process: {..} = "process"

@val
external __dirname: string = "__dirname"

module Path = {
  @module("path") @variadic
  external resolve: array<string> => string = "resolve"
}

module Fs = {
  type err = Unknown

  @module("fs") @scope("promises")
  external _writeFile: (. string, string) => Promise.t<'a> = "writeFile"

  @module("fs") @scope("promises")
  external _readFile: (. string) => Promise.t<'a> = "readFile"

  let writeFile: (string, string) => Promise.t<result<unit, err>> = (data, path) => {
    _writeFile(. path, data)->then(_ => Ok()->resolve)->catch(_ => Error(Unknown)->resolve)
  }

  let readFile: string => Promise.t<result<string, err>> = path => {
    _readFile(. path)
    ->then(res => {
      Ok(res)->resolve
    })
    ->catch(_ => {
      Error(Unknown)->resolve
    })
  }
}
