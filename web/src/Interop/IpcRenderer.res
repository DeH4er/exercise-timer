type event
type listener = Js.Fn.arity0<unit>

@val @scope(("electron", "ipcRenderer"))
external _on: (string, listener) => unit = "on"

@val @scope(("electron", "ipcRenderer")) @variadic
external send: (string, array<string>) => unit = "send"

let on: (string, (event, array<string>) => unit) => listener = (channel, listener) => {
  let listener = Shared.Utils.rest2(listener)
  _on(channel, listener)
  listener
}

@val @scope(("electron", "ipcRenderer"))
external removeListener: (string, listener) => unit = "removeListener"
