let on: ((Electron.IpcMain.event, Shared.Command.t) => unit) => unit = listener => {
  Electron.IpcMain.on("main", (event, args) => {
    switch args {
    | [cmd] =>
      cmd
      ->Shared.Command.Serializable.fromString
      ->Belt.Option.map(cmd => listener(event, cmd))
      ->ignore
    | _ => ()
    }
  })
}

let send: (Shared.Command.t, Electron.WebContents.t) => unit = (command, webContents) => {
  webContents->Electron.WebContents.send("main", [command->Shared.Command.Serializable.toString])
}

let reply: (Electron.IpcMain.event, Shared.Command.t) => unit = (event, command) => {
  event->Electron.IpcMain.reply("main", [command->Shared.Command.Serializable.toString])
}
