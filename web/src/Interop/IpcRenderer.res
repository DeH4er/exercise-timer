type event

type ipcRenderer

@val @scope("electron")
external ipcRenderer: ipcRenderer = "ipcRenderer"

@send
external _on: (ipcRenderer, string, Js.Fn.arity0<'a>) => unit = "on"

@send @variadic
external _send: (ipcRenderer, string, array<string>) => unit = "send"

let on: (string, (event, array<string>) => unit) => unit = (channel, listener) => {
  _on(ipcRenderer, channel, Shared.Utils.rest2(listener))
}

let send: (string, array<string>) => unit = (channel, args) => {
  _send(ipcRenderer, channel, args)
}