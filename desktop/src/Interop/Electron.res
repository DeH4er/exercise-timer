module App = {
  @module("electron") @scope("app")
  external isPackaged: bool = "isPackaged"
  
  @module("electron") @scope("app")
  external whenReady: unit => Promise.t<unit> = "whenReady"

  @module("electron") @scope("app")
  external quit: unit => unit = "quit"
}

module WebContents = {
  type t

  @send
  external on: (t, string, unit => unit) => unit = "on"

  @send @variadic
  external send: (t, array<string>) => unit = "send"

  @send
  external openDevTools: t => unit = "openDevTools"
}

module BrowserWindow = {
  type t = {webContents: WebContents.t}

  type webPreferences = {preload: option<string>}

  type createProps = {
    width: int,
    height: int,
    frame: option<bool>,
    webPreferences: option<webPreferences>,
  }

  @send
  external loadURL: (t, string) => unit = "loadURL"

  @send
  external close: t => unit = "close"

  @send
  external minimize: t => unit = "minimize"

  @new @module("electron")
  external _create: createProps => t = "BrowserWindow"

  let create: (
    ~frame: bool=?,
    ~webPreferences: webPreferences=?,
    ~width: int,
    ~height: int,
    unit,
  ) => t = (~frame=?, ~webPreferences=?, ~width: int, ~height: int, ()) =>
    _create({width: width, height: height, frame: frame, webPreferences: webPreferences})

  @module("electron") @scope("BrowserWindow")
  external fromWebContents: WebContents.t => t = "fromWebContents"
}

module Menu = {
  type t

  type menuItem = {
    label: string,
    click: unit => unit,
  }

  @module("electron") @scope("Menu")
  external create: array<menuItem> => t = "buildFromTemplate"
}

module Tray = {
  type t

  @send
  external setContextMenu: (t, Menu.t) => unit = "setContextMenu"

  @new @module("electron")
  external create: string => t = "Tray"
}

module IpcMain = {
  type event = {
    sender: WebContents.t
  }

  @module("electron") @scope("ipcMain")
  external _on: 'a = "on"

  let on = (. channel, listener) => {
    _on(.channel, () => {
      let args = Shared.Utils.arguments
      listener(args[0], args->Belt.Array.slice(~offset=1, ~len=Belt.Array.length(args)))
    })
  }
}
