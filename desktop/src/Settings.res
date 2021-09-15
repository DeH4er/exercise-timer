let save: Shared.Settings.t => Promise.t<result<unit, string>> = settings => {
  settings->ignore->Ok->Promise.resolve
}

let load: unit => Promise.t<result<Shared.Settings.t, string>> = () => {
  Shared.Settings.default
  ->Ok
  ->Promise.resolve
}
