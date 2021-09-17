type t =
  | CloseWindow
  | MinimizeWindow
  | GetSettings
  | ReturnSettings(Settings.t)
  | SetBreakDuration(int)
  | SetBreakInterval(int)

let decodeCommand: array<string> => option<t> = args => {
  switch args {
  | ["CloseWindow"] => CloseWindow->Some
  | ["MinimizeWindow"] => MinimizeWindow->Some
  | ["ReturnSettings", payload] => payload->Utils.parse->ReturnSettings->Some
  | ["GetSettings"] => GetSettings->Some
  | ["SetBreakDuration", payload] => payload->Utils.parse->SetBreakDuration->Some
  | ["SetBreakInterval", payload] => payload->Utils.parse->SetBreakInterval->Some
  | _ => None
  }
}

let encodeCommand: t => array<string> = command => {
  switch command {
  | CloseWindow => ["CloseWindow"]
  | MinimizeWindow => ["MinimizeWindow"]
  | ReturnSettings(payload) => ["ReturnSettings", payload->Utils.stringify]
  | GetSettings => ["GetSettings"]
  | SetBreakDuration(payload) => ["SetBreakDuration", payload->Utils.stringify]
  | SetBreakInterval(payload) => ["SetBreakInterval", payload->Utils.stringify]
  }
}
