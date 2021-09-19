open Promise
open Electron

type appState = {
  mutable tray: option<Tray.t>,
  mutable settingsWindow: option<BrowserWindow.t>,
  mutable breakWindows: option<array<BrowserWindow.t>>,
  mutable settings: option<Shared.Settings.t>,
  mutable breakTime: int,
}

let appState = {
  tray: None,
  settingsWindow: None,
  settings: None,
  breakWindows: None,
  breakTime: 0,
}

let createWindow = (
  ~width: int,
  ~height: int,
  ~x: option<int>=?,
  ~y: option<int>=?,
  ~startupUrl: string,
  (),
) => {
  let window = BrowserWindow.create(
    ~width,
    ~height,
    ~x,
    ~y,
    ~frame=false,
    ~webPreferences={
      preload: Some(Node.Path.resolve([Paths.scriptsPath, "windowPreload.js"])),
      nativeWindowOpen: true,
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
    | Error(_) => Shared.Settings.default
    }
    appState.settings = Some(settings)
    resolve()
  })
}

let exit = () => {
  appState.settings
  ->Belt.Option.map(settings =>
    settings
    ->Settings.save
    ->then(_ => {
      App.quit()
      resolve()
    })
  )
  ->ignore
}

let openBreakWindows = () => {
  appState.breakWindows =
    Screen.getAllDisplays()
    ->Js.Array2.map(display => {
      let paddingFraction = 0.1
      let horizontalPadding = display.bounds.width *. paddingFraction
      let verticalPadding = display.bounds.height *. paddingFraction

      createWindow(
        ~width=(display.bounds.width -. 2.0 *. horizontalPadding)->Belt.Float.toInt,
        ~height=(display.bounds.height -. 2.0 *. verticalPadding)->Belt.Float.toInt,
        ~x=(display.bounds.x +. horizontalPadding)->Belt.Float.toInt,
        ~y=(display.bounds.y +. verticalPadding)->Belt.Float.toInt,
        ~startupUrl="break",
        (),
      )
    })
    ->Some
}

let rec scheduleBreak = () => {
  appState.settings
  ->Belt.Option.map(settings => {
    Shared.Utils.Timer.setTimeout(() => {
      startBreak()
    }, settings.breakInterval)
  })
  ->ignore
}
and startBreakTimer = () => {
  appState.settings
  ->Belt.Option.map(settings => {
    appState.breakTime = 0

    let interval = ref(None)

    interval.contents = Shared.Utils.Timer.setInterval(() => {
        appState.breakTime = appState.breakTime + 1000

        appState.breakWindows
        ->Belt.Option.map(breakWindows =>
          breakWindows->Js.Array2.map(window =>
            appState.breakTime->ReturnBreakTime->Command.send(window.webContents)
          )
        )
        ->ignore

        if appState.breakTime >= settings.breakDuration {
          interval.contents
          ->Belt.Option.map(interval => interval->Shared.Utils.Timer.clearInterval)
          ->ignore

          scheduleBreakClose()
        }
      }, 1000)->Some
  })
  ->ignore
}
and startBreak = () => {
  switch appState.breakWindows {
  | None =>
    startBreakTimer()
    openBreakWindows()
  | _ => ()
  }
}
and scheduleBreakClose = () => {
  Shared.Utils.Timer.setTimeout(() => {
    appState.breakWindows
    ->Belt.Option.map(breakWindows => breakWindows->Js.Array2.map(BrowserWindow.close))
    ->ignore

    appState.breakWindows = None
    scheduleBreak()
  }, 1000)->ignore
}

let openSettingsWindow = () => {
  switch appState.settingsWindow {
  | None => {
      let window = createWindow(~width=400, ~height=370, ~startupUrl="settings", ())
      appState.settingsWindow = Some(window)
    }
  | _ => ()
  }
}

let createTray = () => {
  let iconPath = Node.Path.resolve([Paths.imgPath, "icon.png"])
  let createdTray = Tray.create(iconPath)
  appState.tray = Some(createdTray)
  let menu = Menu.create([
    {label: "Settings", click: openSettingsWindow},
    {label: "Exit", click: exit},
  ])
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
  | GetSettings =>
    appState.settings
    ->Belt.Option.map(settings => settings->ReturnSettings->Command.send(event.sender))
    ->ignore
  | SetBreakDuration(breakDuration) =>
    appState.settings
    ->Belt.Option.map(settings => {
      appState.settings = {...settings, breakDuration: breakDuration}->Some
    })
    ->ignore
  | SetBreakInterval(breakInterval) =>
    appState.settings
    ->Belt.Option.map(settings => {
      appState.settings = {...settings, breakInterval: breakInterval}->Some
    })
    ->ignore
  | ChangeLanguage(language) => {
    appState.settings
    ->Belt.Option.map(settings => {
      appState.settings = {...settings, selectedLanguage: language}->Some
      BrowserWindow.getAllWindows()
      ->Js.Array2.map(window => LanguageChanged(language)->Command.send(window.webContents))
    })
    ->ignore
  }
  | LanguageChanged(_) => ()
  | ReturnBreakTime(_) => ()
  | ReturnSettings(_) => ()
  }
})

App.whenReady()
->then(() => {
  installDevTools()
  loadSettings()->then(() => {
    createTray()
    scheduleBreak()
    resolve()
  })
})
->ignore

App.on("window-all-closed", ignore)
