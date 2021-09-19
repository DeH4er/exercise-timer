let on: (Shared.Command.t => unit) => IpcRenderer.listener = listener => {
  IpcRenderer.on("main", (_, args) => {
    args->Shared.Command.decodeCommand->Belt.Option.map(listener)->ignore
  })
}

let send: Shared.Command.t => unit = command => {
  command->Shared.Command.encodeCommand->(parts => IpcRenderer.send("main", parts))
}

let removeListener = IpcRenderer.removeListener("main")