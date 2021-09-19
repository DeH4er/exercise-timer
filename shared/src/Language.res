type t = Ru | En

let supportedLanguages: array<t> = [En, Ru]

let toString: t => string = language => {
  switch language {
  | Ru => "ru"
  | En => "en"
  }
}

let fromString: string => option<t> = language => {
  switch language {
  | "ru" => Ru->Some
  | "en" => En->Some
  | _ => None
  }
}
