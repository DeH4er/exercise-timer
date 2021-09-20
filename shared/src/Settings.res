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
  selectedLanguage: Language.t,
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
    selectedLanguage: En,
  }
}

module Codec = {
  type t = t

  let default = Jzon.object9(
    ({
      maxBreakInterval,
      minBreakInterval,
      tickBreakInterval,
      breakInterval,
      maxBreakDuration,
      minBreakDuration,
      tickBreakDuration,
      breakDuration,
      selectedLanguage,
    }) => (
      maxBreakInterval,
      minBreakInterval,
      tickBreakInterval,
      breakInterval,
      maxBreakDuration,
      minBreakDuration,
      tickBreakDuration,
      breakDuration,
      selectedLanguage,
    ),
    ((
      maxBreakInterval,
      minBreakInterval,
      tickBreakInterval,
      breakInterval,
      maxBreakDuration,
      minBreakDuration,
      tickBreakDuration,
      breakDuration,
      selectedLanguage,
    )) => {
      {
        maxBreakInterval: maxBreakInterval,
        tickBreakInterval: tickBreakInterval,
        minBreakInterval: minBreakInterval,
        breakInterval: breakInterval,
        maxBreakDuration: maxBreakDuration,
        minBreakDuration: minBreakDuration,
        tickBreakDuration: tickBreakDuration,
        breakDuration: breakDuration,
        selectedLanguage: selectedLanguage,
      }->Ok
    },
    Jzon.field("maxBreakInterval", Jzon.int),
    Jzon.field("minBreakInterval", Jzon.int),
    Jzon.field("tickBreakInterval", Jzon.int),
    Jzon.field("breakInterval", Jzon.int),
    Jzon.field("maxBreakDuration", Jzon.int),
    Jzon.field("minBreakDuration", Jzon.int),
    Jzon.field("tickBreakDuration", Jzon.int),
    Jzon.field("breakDuration", Jzon.int),
    Jzon.field("selectedLanguage", Language.Codec.default),
  )
}

module Serializable = Serializable.MakeSerializable(Codec)