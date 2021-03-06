module App = {
  type event

  @module("electron") @scope("app")
  external isPackaged: bool = "isPackaged"

  @module("electron") @scope("app")
  external whenReady: unit => Promise.t<unit> = "whenReady"

  @module("electron") @scope("app")
  external quit: unit => unit = "quit"

  @module("electron") @scope("app")
  external on: (string, event => unit) => unit = "on"

  type pathName = [#userData]

  @module("electron") @scope("app")
  external _getPathUnsafe: string => string = "getPath"

  let getPath: pathName => string = pathName => _getPathUnsafe((pathName :> string))
}

module WebContents = {
  type t

  @send
  external on: (t, string, unit => unit) => unit = "on"

  @send @variadic
  external send: (t, string, array<string>) => unit = "send"

  @send
  external openDevTools: t => unit = "openDevTools"
}

module BrowserWindow = {
  type t = {webContents: WebContents.t}

  @send
  external loadURL: (t, string) => unit = "loadURL"

  @send
  external close: t => unit = "close"

  @send
  external minimize: t => unit = "minimize"

  module WebPreferencesProps = {
    type t

    @obj
    external create: (~preload: string=?, ~nativeWindowOpen: bool=?, unit) => t = ""
  }

  module WebPreferencesPropsUtils = Shared.Props.MakePropsUtils(WebPreferencesProps)

  module CreateProps = {
    type t

    @obj
    external create: (
      ~width: int=?,
      ~height: int=?,
      ~x: int=?,
      ~y: int=?,
      ~frame: bool=?,
      ~webPreferences: WebPreferencesProps.t=?,
      ~skipTaskbar: bool=?,
      ~alwaysOnTop: bool=?,
      unit,
    ) => t = ""
  }

  module CreatePropsUtils = Shared.Props.MakePropsUtils(CreateProps)

  @new @module("electron")
  external create: CreateProps.t => t = "BrowserWindow"

  @module("electron") @scope("BrowserWindow")
  external fromWebContents: WebContents.t => t = "fromWebContents"

  @module("electron") @scope("BrowserWindow")
  external getAllWindows: unit => array<t> = "getAllWindows"
}

module Menu = {
  type t

  module CreateProps = {
    type t

    @obj
    external create: (~label: string=?, ~click: unit => unit=?, unit) => t = ""
  }

  module CreatePropsUtils = Shared.Props.MakePropsUtils(CreateProps)

  @module("electron") @scope("Menu")
  external create: array<CreateProps.t> => t = "buildFromTemplate"
}

module Tray = {
  type t

  @send
  external setContextMenu: (t, Menu.t) => unit = "setContextMenu"

  @new @module("electron")
  external create: string => t = "Tray"
}

module IpcMain = {
  type event = {sender: WebContents.t}

  @send @variadic
  external reply: (event, string, array<string>) => unit = "reply"

  @module("electron") @scope("ipcMain")
  external _on: (string, Js.Fn.arity0<'a>) => unit = "on"

  let on: (string, (event, array<string>) => unit) => unit = (channel, listener) => {
    _on(channel, Shared.Utils.rest2(listener))
  }
}

module Display = {
  type rect = {
    x: float,
    y: float,
    width: float,
    height: float,
  }

  type t = {bounds: rect}
}

module Screen = {
  @module("electron") @scope("screen")
  external getAllDisplays: unit => array<Display.t> = "getAllDisplays"
}
