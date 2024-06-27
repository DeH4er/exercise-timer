type i18n = {language: string}
type i18nExtension

@module("i18next")
external i18n: i18n = "default"

@send
external use: (i18n, 'a) => i18n = "use"

@send
external init: (i18n, {..}) => i18n = "init"

@module("react-i18next")
external initReactI18next: i18nExtension = "initReactI18next"

@module("../../assets/i18n/en.json")
external enTranslations: {..} = "default"

@module("../../assets/i18n/ua.json")
external uaTranslations: {..} = "default"

type useTranslationRecord<'a> = {
  t: string => string,
  t1: (string, 'a) => string,
  i18n: i18n,
}

@module("react-i18next")
external _useTranslation: unit => {..} = "useTranslation"

let useTranslation = () => {
  let res = _useTranslation()

  {
    t: key => res["t"](. key),
    t1: (key, args) => res["t"](. key, args),
    i18n: res["i18n"],
  }
}

@send
external _changeLanguage: (i18n, string) => unit = "changeLanguage"

let changeLanguage: (i18n, Shared.Language.t) => unit = (i18n, language) => {
  _changeLanguage(i18n, language->Shared.Language.Serializable.toString)
}

let init = () => {
  i18n
  ->use(initReactI18next)
  ->init({
    "resources": {
      "en": {
        "translation": enTranslations,
      },
      "ua": {
        "translation": uaTranslations,
      },
    },
    "lng": "en",
    "fallbackLng": "en",
    "interpolation": {
      "escapeValue": false,
    },
  })
}

let listenChange: unit => unit = () => {
  Command.on(cmd => {
    switch cmd {
    | ReturnSettings(settings) => i18n->changeLanguage(settings.selectedLanguage)
    | LanguageChanged(language) => i18n->changeLanguage(language)
    | _ => ()
    }
  })->ignore

  GetSettings->Command.send
}
