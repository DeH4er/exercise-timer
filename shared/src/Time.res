let hoursToMillis: float => int = hours => {
  Belt.Float.toInt(hours *. 3_600_000.)
}

let minutesToMillis: int => int = minutes => {
  minutes * 60_000
}

let millisToString: int => string = ms => {
  let seconds = ms / 1000
  let minutes = seconds / 60
  let hours = minutes / 60
  let minutes = minutes - hours * 60

  let minutesStr = j`$minutes minute${minutes > 1 ? "s" : ""}`
  let hoursStr = j`$hours hour${hours > 1 ? "s" : ""}`

  switch (hours, minutes) {
  | (0, 0) => assert false
  | (_, 0) => hoursStr
  | (0, _) => minutesStr
  | (_, _) => `${hoursStr} ${minutesStr}`
  }
}