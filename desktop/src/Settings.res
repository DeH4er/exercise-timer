let save: Shared.Settings.t => Promise.t<result<unit, Node.Fs.err>> = settings => {
  settings->JsonStorage.set("settings")
}

let load: unit => Promise.t<result<Shared.Settings.t, Node.Fs.err>> = () => {
  JsonStorage.get("settings")
}
