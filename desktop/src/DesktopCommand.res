let onCommand: ((Electron.IpcMain.event, Shared.Command.t) => unit) => unit = listener => {
  Electron.IpcMain.on(."main", (event, args) => {
    args->Shared.Command.decodeCommand->Belt.Option.map(cmd => listener(event, cmd))
  })
}

let sendCommand: (Shared.Command.t, Electron.WebContents.t) => unit = (command, webContents) => {
  webContents->Electron.WebContents.send(command->Shared.Command.encodeCommand)
}