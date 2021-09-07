type t = CloseWindow | MinimizeWindow

let decodeCommand: array<string> => option<t> = (args) => {
  switch args {
  | ["closeWindow"] => Some(CloseWindow)
  | ["minimizeWindow"] => Some(MinimizeWindow)
  | _ => None
  }
}

let encodeCommand: t => array<string> = command => {
  switch command {
  | CloseWindow => ["closeWindow"]
  | MinimizeWindow => ["minimizeWindow"]
  }
}
