type t = Ru | En

let supportedLanguages: array<t> = [En, Ru]

module Codec = {
  type t = t

  let default: Jzon.codec<t> = Jzon.custom(
    language => {
      switch language {
      | Ru => "ru"
      | En => "en"
      }->Jzon.encodeWith(Jzon.string)
    },
    languageStr => {
      languageStr
      ->Jzon.decodeWith(Jzon.string)
      ->Belt.Result.flatMap(language =>
       switch language {
        | "ru" => Ru->Ok
        | "en" => En->Ok
        | lng => Error(#SyntaxError(`Invalid language ${lng}`))
      })
    },
  )
}

module Serializable = {
  type t = t

  let toString: t => string = language => switch language {
    | Ru => "ru"
    | En => "en"
  }

  let fromString: string => option<t> = languageStr => switch languageStr {
    | "ru" => Ru -> Some
    | "en" => En -> Some
    | lng => {
      Js.log(`${lng} is invalid language`)
      None
    }
  }
    
}