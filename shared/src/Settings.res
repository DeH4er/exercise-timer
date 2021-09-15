type t = {
  maxBreakInterval: int,
  minBreakInterval: int,
  breakInterval: int,
  maxBreakDuration: int,
  minBreakDuration: int,
  breakDuration: int,
}

let default: t = {
  {
    maxBreakInterval: 10,
    minBreakInterval: 0,
    breakInterval: 0,
    maxBreakDuration: 10,
    minBreakDuration: 0,
    breakDuration: 0,
  }
}
