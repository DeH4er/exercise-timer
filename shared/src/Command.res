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

module Codec = {
  type t = t

  let int = Jzon.object1(i => i, i => i->Ok, Jzon.field("int", Jzon.int))
  let language = Jzon.object1(language => language, language => language->Ok, Jzon.field("language", Language.Codec.default))
  let emptyObject = Js.Json.object_(Js.Dict.empty())

  let default = Jzon.object2(
    shape => {
      switch shape {
      | CloseWindow => ("CloseWindow", emptyObject)
      | MinimizeWindow => ("MinimizeWindow", emptyObject)
      | GetSettings => ("GetSettings", emptyObject)
      | ReturnSettings(payload) => (
          "ReturnSettings",
          payload->Jzon.encodeWith(Settings.Codec.default),
        )
      | SetBreakDuration(payload) => ("SetBreakDuration", payload->Jzon.encodeWith(int))
      | SetBreakInterval(payload) => ("SetBreakInterval", payload->Jzon.encodeWith(int))
      | ReturnBreakTime(payload) => ("ReturnBreakTime", payload->Jzon.encodeWith(int))
      | ChangeLanguage(payload) => (
          "ChangeLanguage",
          payload->Jzon.encodeWith(language),
        )
      | LanguageChanged(payload) => (
          "LanguageChanged",
          payload->Jzon.encodeWith(language),
        )
      }
    },
    ((kind, json)) => {
      switch kind {
      | "CloseWindow" => CloseWindow->Ok
      | "MinimizeWindow" => MinimizeWindow->Ok
      | "GetSettings" => GetSettings->Ok
      | "ReturnSettings" =>
        json
        ->Jzon.decodeWith(Settings.Codec.default)
        ->Belt.Result.map(decoded => decoded->ReturnSettings)
      | "SetBreakDuration" =>
        json->Jzon.decodeWith(int)->Belt.Result.map(decoded => decoded->SetBreakDuration)
      | "SetBreakInterval" =>
        json->Jzon.decodeWith(int)->Belt.Result.map(decoded => decoded->SetBreakInterval)
      | "ReturnBreakTime" =>
        json->Jzon.decodeWith(int)->Belt.Result.map(decoded => decoded->ReturnBreakTime)
      | "ChangeLanguage" =>
        json
        ->Jzon.decodeWith(language)
        ->Belt.Result.map(decoded => decoded->ChangeLanguage)
      | "LanguageChanged" =>
        json
        ->Jzon.decodeWith(language)
        ->Belt.Result.map(decoded => decoded->LanguageChanged)
      | kind => Error(#UnexpectedJsonValue([Field("kind")], kind))
      }
    },
    Jzon.field("kind", Jzon.string),
    Jzon.self,
  )
}

module Serializable = Serializable.MakeSerializable(Codec)