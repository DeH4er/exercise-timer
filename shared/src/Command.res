type t =
  | CloseWindow
  | MinimizeWindow
  | GetSettings
  | ReturnSettings(Settings.t)
  | SetBreakDuration(int)
  | SetBreakInterval(int)
  | ReturnBreakTime(int)
  | ChangeLanguage(Language.t)
  | LanguageChanged(Language.t)

let decodeCommand: array<string> => option<t> = args => {
  switch args {
  | ["CloseWindow"] => CloseWindow->Some
  | ["MinimizeWindow"] => MinimizeWindow->Some
  | ["ReturnSettings", payload] => payload->Utils.parse->ReturnSettings->Some
  | ["GetSettings"] => GetSettings->Some
  | ["SetBreakDuration", payload] => payload->Utils.parse->SetBreakDuration->Some
  | ["SetBreakInterval", payload] => payload->Utils.parse->SetBreakInterval->Some
  | ["ReturnBreakTime", payload] => payload->Utils.parse->ReturnBreakTime->Some
  | ["ChangeLanguage", payload] =>
    payload->Language.fromString->Belt.Option.map(language => language->ChangeLanguage)
  | ["LanguageChanged", payload] =>
    payload->Language.fromString->Belt.Option.map(language => language->LanguageChanged)
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
  | ReturnBreakTime(payload) => ["ReturnBreakTime", payload->Utils.stringify]
  | ChangeLanguage(payload) => ["ChangeLanguage", payload->Language.toString]
  | LanguageChanged(payload) => ["LanguageChanged", payload->Language.toString]
  }
}
