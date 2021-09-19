open Time

type t = {
  maxBreakInterval: int,
  minBreakInterval: int,
  tickBreakInterval: int,
  breakInterval: int,
  maxBreakDuration: int,
  minBreakDuration: int,
  tickBreakDuration: int,
  breakDuration: int,
  selectedLanguage: Language.t
}

let default: t = {
  {
    maxBreakInterval: 2.5->hoursToMillis,
    minBreakInterval: 0.5->hoursToMillis,
    tickBreakInterval: 5->minutesToMillis,
    breakInterval: 1.0->hoursToMillis,
    maxBreakDuration: 30->minutesToMillis,
    minBreakDuration: 5->minutesToMillis,
    tickBreakDuration: 1->minutesToMillis,
    breakDuration: 5->minutesToMillis,
    selectedLanguage: En
  }
}
