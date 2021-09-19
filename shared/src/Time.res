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

let millisToString = (
  millis: int,
  ~seconds: bool=true,
  ~minutes: bool=true,
  ~hours: bool=true,
  (),
) => {
  let time = millisToTime(millis)

  let hoursStr = "hour"
  let minutesStr = "minute"
  let secondsStr = "second"

  let arr: array<(int, string)> = []

  if hours {
    arr->Js.Array2.push((time.hours, hoursStr))->ignore
  }

  if minutes {
    arr->Js.Array2.push((time.minutes, minutesStr))->ignore
  }

  if seconds {
    arr->Js.Array2.push((time.seconds, secondsStr))->ignore
  }

  arr
  ->Js.Array2.filter(((time, _)) => time > 0)
  ->Js.Array2.map(((time, str)) => {
    j`$time ${time == 1 ? str : str ++ "s"}`
  })
  ->Js.Array2.joinWith(" ")
}
