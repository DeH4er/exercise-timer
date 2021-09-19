type t = {
  seconds: int,
  minutes: int,
  hours: int,
}

let hoursToMillis: float => int = hours => {
  Belt.Float.toInt(hours *. 3_600_000.)
}

let minutesToMillis: int => int = minutes => {
  minutes * 60_000
}

let millisToTime: int => t = millis => {
  let seconds = millis / 1000
  let minutes = seconds / 60
  let seconds = seconds - minutes * 60
  let hours = minutes / 60
  let minutes = minutes - hours * 60

  {
    seconds: seconds,
    minutes: minutes,
    hours: hours,
  }
}
