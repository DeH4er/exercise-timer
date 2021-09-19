@module("./LanguageSelector.css")
external styles: {..} = "default"

@react.component
let make = () => {
  let {t1, i18n} = Translate.useTranslation()
  let supportedLanguages = Shared.Language.supportedLanguages

  let selectLanguage = language => {
    language->ChangeLanguage->Command.send
  }

  <div className="language-selector">
    {
      supportedLanguages
      ->Js.Array2.map(language => {
        let languageStr = Shared.Language.toString(language)
        let isSelected = i18n.language == languageStr
        <div
            className=`language-selector__language ${isSelected ? "language-selector__language--selected" : ""}`
            onClick={_ => language->selectLanguage}>
          {`LANGUAGE.${languageStr->Js.String.toUpperCase}`->t1({"lng": languageStr})->React.string}
        </div>
      })
      ->React.array
    }
  </div>
}
