@val
external process: {..} = "process"

@val
external __dirname: string = "__dirname"

module Path = {
  @module("path") @variadic
  external join: array<string> => string = "join"
}