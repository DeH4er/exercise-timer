let on: ((Electron.IpcMain.event, Shared.Command.t) => unit) => unit = listener => {
  Electron.IpcMain.on(."main", (event, args) => {
    args->Shared.Command.decodeCommand->Belt.Option.map(cmd => listener(event, cmd))
  })
}

let send: (Shared.Command.t, Electron.WebContents.t) => unit = (command, webContents) => {
  webContents->Electron.WebContents.send("main", command->Shared.Command.encodeCommand)
}

let reply: (Electron.IpcMain.event, Shared.Command.t) => unit = (event, command) => {
  event->Electron.IpcMain.reply("main", command->Shared.Command.encodeCommand)
}