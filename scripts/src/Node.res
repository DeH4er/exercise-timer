@val
external __dirname: string = "__dirname"

module Fs = {
  @module("fs")
  external _writeFileSync: (string, string) => unit = "writeFileSync"

  let writeFileSync = (content, path) => {
    _writeFileSync(path, content)
  }
}

module Path = {
  @module("path") @variadic
  external resolve: array<string> => string = "resolve"
}