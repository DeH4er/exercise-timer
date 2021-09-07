@val @scope("electron")
external ipcRenderer: 'a = "ipcRenderer"

@send
external _on: ('a, string, 'b) => unit = "on"

@send @variadic
external send: ('a, string, array<string>) => unit = "send"

@val
external arguments: array<'a> = "arguments"

let on: (string, (string, array<string>) => unit) => unit = (channel, listener) => {
  _on(ipcRenderer, channel, () => {
    let args: array<string> = arguments
    listener(args[0], args->Belt.Array.slice(~offset=1, ~len=Belt.Array.length(args)))
  })
}

let onCommand: (Command.t => unit) => unit = listener => {
  on("main", (_, args) => {
    args->Command.decodeCommand->Belt.Option.map(listener)->ignore
  })
}

let sendCommand: Command.t => unit = command => {
  command->Command.encodeCommand->(parts => send(ipcRenderer, "main", parts))
}
