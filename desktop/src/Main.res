open Promise
open Electron

type appState = {
  mutable tray: option<Tray.t>,
  mutable settingsWindow: option<BrowserWindow.t>,
  mutable settings: option<Shared.Settings.t>,
}

let appState = {
  tray: None,
  settingsWindow: None,
  settings: None,
}

let createWindow = (~width: int, ~height: int, ~startupUrl: string, ()) => {
  let window = BrowserWindow.create(
    ~width,
    ~height,
    ~frame=false,
    ~webPreferences={
      preload: Some(Node.Path.join([Paths.scriptsPath, "windowPreload.js"])),
    },
    (),
  )
  let url = `${Paths.webPath}#${startupUrl}`
  window->BrowserWindow.loadURL(url)

  if !App.isPackaged {
    window.webContents->WebContents.openDevTools
  }

  window
}

let loadSettings = () => {
  Settings.load()->then(res => {
    let settings = switch res {
    | Ok(settings) => settings
    | Error(err) => {
        Js.log(err)
        Shared.Settings.defaultSettings
      }
    }
    appState.settings = Some(settings)
    resolve()
  })
}

let exit = App.quit

let openSettings = () => {
  switch appState.settingsWindow {
  | None => {
      let window = createWindow(~width=400, ~height=250, ~startupUrl="settings", ())
      appState.settingsWindow = Some(window)
    }
  | _ => ()
  }
}

let createTray = () => {
  let iconPath = Node.Path.join([Paths.imgPath, "icon.png"])
  let createdTray = Tray.create(iconPath)
  appState.tray = Some(createdTray)
  let menu = Menu.create([{label: "Settings", click: openSettings}, {label: "Exit", click: exit}])
  Tray.setContextMenu(createdTray, menu)
}

let installDevTools = () => {
  if !App.isPackaged {
    ElectronDevtoolsInstaller.reactDevtools->ElectronDevtoolsInstaller.installExtension->ignore
  }
}

Command.on((event, command) => {
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
  | GetSettings => appState.settings -> Belt.Option.map(settings => event->Command.reply(settings->ReturnSettings)) -> ignore
  | SetBreakDuration(breakDuration) => appState.settings -> Belt.Option.map(settings => {
      appState.settings = {...settings, breakDuration}->Some
    }) -> ignore
  | SetBreakInterval(breakInterval) => appState.settings -> Belt.Option.map(settings => {
      appState.settings = {...settings, breakInterval}->Some
    }) -> ignore
  | ReturnSettings(_) => ()
  }
})

App.whenReady()
->then(() => {
  installDevTools()
  loadSettings()->then(() => {
    createTray()
    resolve()
  })
})
->ignore
