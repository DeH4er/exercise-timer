type t = CloseWindow | MinimizeWindow | GetSettings | ReturnSettings(Settings.t) | SetBreakDuration(int) | SetBreakInterval(int)

@scope("JSON") @val
external decodeSettings: string => Settings.t = "parse"

@scope("JSON") @val
external encodeSettings: Settings.t => string = "stringify"

@scope("JSON") @val
external decodeInt: string => int = "parse"

@scope("JSON") @val
external encodeInt: int => string = "stringify"

let decodeCommand: array<string> => option<t> = (args) => {
  switch args {
  | ["CloseWindow"] => CloseWindow->Some
  | ["MinimizeWindow"] => MinimizeWindow->Some
  | ["ReturnSettings", payload] => payload->decodeSettings->ReturnSettings->Some
  | ["GetSettings"] => GetSettings->Some
  | ["SetBreakDuration", payload] => payload->decodeInt->SetBreakDuration->Some
  | ["SetBreakInterval", payload] => payload->decodeInt->SetBreakInterval->Some
  | _ => None
  }
}

let encodeCommand: t => array<string> = command => {
  switch command {
  | CloseWindow => ["CloseWindow"]
  | MinimizeWindow => ["MinimizeWindow"]
  | ReturnSettings(payload) => ["ReturnSettings", payload->encodeSettings]
  | GetSettings => ["GetSettings"]
  | SetBreakDuration(payload) => ["SetBreakDuration", payload->encodeInt]
  | SetBreakInterval(payload) => ["SetBreakInterval", payload->encodeInt]
  }
}
