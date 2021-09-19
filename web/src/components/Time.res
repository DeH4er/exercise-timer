@react.component
let make = (~hours: option<int>=?, ~minutes: option<int>=?, ~seconds: option<int>=?) => {
  let {t1} = Translate.useTranslation()

  let timeString: (string, option<int>) => option<string> = (key, time) => {
    time
    ->Belt.Option.flatMap(time => time > 0 ? Some(time) : None)
    ->Belt.Option.map(time => key->t1({"count": time}))
  }

  [
    timeString("TIME.HOURS", hours),
    timeString("TIME.MINUTES", minutes),
    timeString("TIME.SECONDS", seconds),
  ]
  ->Belt.Array.keepMap(time => time)
  ->Js.Array2.joinWith(" ")
  ->React.string
}
