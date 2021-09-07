let onCommand: ((Electron.IpcMain.event, Command.t) => unit) => unit = listener => {
  Electron.IpcMain.on(."main", (event, args) => {
    args->Command.decodeCommand->Belt.Option.map(cmd => listener(event, cmd))
  })
}

let sendCommand: (Command.t, Electron.WebContents.t) => unit = (command, webContents) => {
  webContents->Electron.WebContents.send(command->Command.encodeCommand)
}