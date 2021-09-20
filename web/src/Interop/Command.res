let on: (Shared.Command.t => unit) => IpcRenderer.listener = listener => {
  IpcRenderer.on("main", (_, args) => {
    switch args {
    | [cmd] => cmd->Shared.Command.Serializable.fromString->Belt.Option.map(listener)->ignore
    | _ => ()
    }
  })
}

let send: Shared.Command.t => unit = command => {
  command->Shared.Command.Serializable.toString->(parts => IpcRenderer.send("main", [parts]))
}

let removeListener = IpcRenderer.removeListener("main")
