let on: (Shared.Command.t => unit) => unit = listener => {
  IpcRenderer.on("main", (_, args) => {
    args->Shared.Command.decodeCommand->Belt.Option.map(listener)->ignore
  })
}

let send: Shared.Command.t => unit = command => {
  command->Shared.Command.encodeCommand->(parts => IpcRenderer.send("main", parts))
}
