type ipcRenderer

@val @scope("electron")
external ipcRenderer: ipcRenderer = "ipcRenderer"

@send
external _on: (ipcRenderer, string, 'a) => unit = "on"

@send @variadic
external send: (ipcRenderer, string, array<string>) => unit = "send"

@val
external arguments: array<'a> = "arguments"

let on: (string, (string, array<string>) => unit) => unit = (channel, listener) => {
  _on(ipcRenderer, channel, () => {
    let args: array<string> = arguments
    listener(args[0], args->Belt.Array.slice(~offset=1, ~len=Belt.Array.length(args)))
  })
}

let onCommand: (Shared.Command.t => unit) => unit = listener => {
  on("main", (_, args) => {
    args->Shared.Command.decodeCommand->Belt.Option.map(listener)->ignore
  })
}

let sendCommand: Shared.Command.t => unit = command => {
  command->Shared.Command.encodeCommand->(parts => send(ipcRenderer, "main", parts))
}
