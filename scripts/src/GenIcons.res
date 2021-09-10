@module
external icons: {..} = "react-feather"

let getIcons = () => {
  Js.Obj.keys(icons)
}

let makeType = "(~size: int=?) => React.element"

let genIcon: string => string = iconName => {
`
module ${iconName} = {
  @module("react-feather") @react.component
  external make: ${makeType} = "${iconName}"
}
`
->Js.String.trim
}

let save: string => unit = code => {
  code -> Node.Fs.writeFileSync(Paths.featherIconsPath)
}

let run = () => {
  let icons = getIcons()

  let iconsCode = icons
    -> Js.Array2.map(genIcon)
    -> Js.Array2.joinWith("\n\n")

  
    ("// Do not modify! This file is generated automatically by scripts\n\n" ++ iconsCode)
    -> save
}

run()