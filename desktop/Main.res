open Promise
open Electron

type settings = {
  breakDuration: int,
  breakInterval: int,
}

type appState = {
  mutable tray: option<Tray.t>,
  mutable settingsWindow: option<BrowserWindow.t>,
  settings: settings,
}

let appState = {
  tray: None,
  settingsWindow: None,
  settings: {
    breakDuration: 0,
    breakInterval: 0,
  },
}

let createWindow = (~width: int, ~height: int, ~startupUrl: string, ()) => {
  let window = BrowserWindow.create(
    ~width,
    ~height,
    ~frame=false,
    ~webPreferences={
      preload: Some(Node.Path.join([DesktopPaths.scriptsPath, "windowPreload.js"])),
    },
    (),
  )
  let url = `${DesktopPaths.webPath}#${startupUrl}`
  window->BrowserWindow.loadURL(url)

  if !Electron.App.isPackaged {
    window.webContents->WebContents.openDevTools
  }

  window
}

let exit = App.quit
let openSettings = () => {
  switch appState.settingsWindow {
  | None => {
      let window = createWindow(~width=800, ~height=400, ~startupUrl="settings", ())
      appState.settingsWindow = Some(window)
    }
  | _ => ()
  }
}

DesktopCommand.onCommand((event, command) => {
  let window = event.sender->BrowserWindow.fromWebContents

  switch command {
  | CloseWindow =>
    window->BrowserWindow.close

    appState.settingsWindow
    ->Belt.Option.map(settingsWindow => {
      if window == settingsWindow {
        appState.settingsWindow = None
      }
    })
    ->ignore
  | MinimizeWindow => window->BrowserWindow.minimize
  }
})

App.whenReady()
->then(() => {
  if !App.isPackaged {
    ElectronDevtoolsInstaller.reactDevtools->ElectronDevtoolsInstaller.installExtension->ignore
  }

  let iconPath = Node.Path.join([DesktopPaths.imgPath, "icon.png"])
  let createdTray = Tray.create(iconPath)
  appState.tray = Some(createdTray)
  let menu = Menu.create([{label: "Settings", click: openSettings}, {label: "Exit", click: exit}])
  Tray.setContextMenu(createdTray, menu)
  resolve()
})
->ignore
