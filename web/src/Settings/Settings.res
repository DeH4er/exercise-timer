@module("./Settings.css")
external styles: {..} = "default"

type settingsAction =
  LoadComplete(Shared.Settings.t) | SetBreakInterval(int) | SetBreakDuration(int)

let reducer: (Shared.Settings.t, settingsAction) => Shared.Settings.t = (state, action) => {
  switch action {
  | SetBreakInterval(breakInterval) => {...state, breakInterval: breakInterval}
  | SetBreakDuration(breakDuration) => {...state, breakDuration: breakDuration}
  | LoadComplete(settings) => settings
  }
}

@react.component
let make = () => {
  let (settings, dispatch) = React.useReducer(reducer, Shared.Settings.default)
  let {t} = Translate.useTranslation()
  let breakIntervalTime = settings.breakInterval->Shared.Time.millisToTime
  let breakDurationTime = settings.breakDuration->Shared.Time.millisToTime

  React.useEffect0(() => {
    let listener = Command.on(cmd => {
      switch cmd {
      | ReturnSettings(settings) => settings->LoadComplete->dispatch
      | _ => ()
      }
    })

    Shared.Command.GetSettings->Command.send

    Some(
      () => {
        Command.removeListener(listener)
      },
    )
  })

  let onBreakIntervalChange = value => {
    value->Belt.Float.toInt->Shared.Command.SetBreakInterval->Command.send
    value->Belt.Float.toInt->SetBreakInterval->dispatch
  }

  let onBreakDurationChange = value => {
    value->Belt.Float.toInt->Shared.Command.SetBreakDuration->Command.send
    value->Belt.Float.toInt->SetBreakDuration->dispatch
  }

  <Window title="SETTINGS.TITLE" maximize=false>
    <div className="settings">
      <section className="settings__section">
        <h3> {"SETTINGS.LANGUAGE"->t->React.string} </h3>
        <LanguageSelector />
      </section>
      <section className="settings__section">
        <h3> {"SETTINGS.BREAK_INTERVAL"->t->React.string} </h3>
        <div className="settings__slider">
          <Slider
            min={settings.minBreakInterval->Belt.Int.toFloat}
            max={settings.maxBreakInterval->Belt.Int.toFloat}
            value={settings.breakInterval->Belt.Int.toFloat}
            step={settings.tickBreakInterval->Belt.Int.toFloat}
            onChange={onBreakIntervalChange}
          />
        </div>
        <p className="settings__detail">
          <Time hours={breakIntervalTime.hours} minutes={breakIntervalTime.minutes} />
        </p>
      </section>
      <section className="settings__section">
        <h3> {"SETTINGS.BREAK_DURATION"->t->React.string} </h3>
        <div className="settings__slider">
          <Slider
            min={settings.minBreakDuration->Belt.Int.toFloat}
            max={settings.maxBreakDuration->Belt.Int.toFloat}
            value={settings.breakDuration->Belt.Int.toFloat}
            step={settings.tickBreakDuration->Belt.Int.toFloat}
            onChange={onBreakDurationChange}
          />
        </div>
        <p className="settings__detail">
          <Time hours={breakDurationTime.hours} minutes={breakDurationTime.minutes} />
        </p>
      </section>
    </div>
  </Window>
}
