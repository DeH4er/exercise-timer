@module("./Settings.css")
external styles: {..} = "default"

type settingsAction =
  LoadComplete(Shared.Settings.t) | SetBreakInterval(int) | SetBreakDuration(int)

type ui = {
  breakIntervalMsg: string,
  breakDurationMsg: string,
}

type state = {
  settings: Shared.Settings.t,
  ui: ui,
}

let settingsReducer: (Shared.Settings.t, settingsAction) => Shared.Settings.t = (state, action) => {
  switch action {
  | SetBreakInterval(breakInterval) => {...state, breakInterval: breakInterval}
  | SetBreakDuration(breakDuration) => {...state, breakDuration: breakDuration}
  | LoadComplete(settings) => settings
  }
}

let uiReducer: (ui, settingsAction) => ui = (state, action) => {
  switch action {
  | SetBreakInterval(breakInterval) => {...state, breakIntervalMsg: Shared.Time.millisToString(breakInterval)}
  | SetBreakDuration(breakDuration) => {...state, breakDurationMsg: Shared.Time.millisToString(breakDuration)}
  | LoadComplete(settings) => {
      breakIntervalMsg: Shared.Time.millisToString(settings.breakInterval),
      breakDurationMsg: Shared.Time.millisToString(settings.breakDuration),
    }
  }
}

let reducer: (state, settingsAction) => state = (state, action) => {
  {
    settings: settingsReducer(state.settings, action),
    ui: uiReducer(state.ui, action),
  }
}

@react.component
let make = () => {
  let ({settings, ui}, dispatch) = React.useReducer(
    reducer,
    {settings: Shared.Settings.default, ui: {breakIntervalMsg: "", breakDurationMsg: ""}},
  )

  React.useEffect0(() => {
    let listener = Command.on(cmd => {
      switch cmd {
      | ReturnSettings(settings) => settings->LoadComplete->dispatch
      | _ => ()
      }
    })

    Shared.Command.GetSettings->Command.send

    Some(() => {
      Command.removeListener(listener)
    })
  })

  let onBreakIntervalChange = value => {
    value->Belt.Float.toInt->Shared.Command.SetBreakInterval->Command.send
    value->Belt.Float.toInt->SetBreakInterval->dispatch
  }

  let onBreakDurationChange = value => {
    value->Belt.Float.toInt->Shared.Command.SetBreakDuration->Command.send
    value->Belt.Float.toInt->SetBreakDuration->dispatch
  }

  <Window title="Settings" maximize=false>
    <div className="settings">
      <section className="settings__section">
        <h3> {React.string("Break interval")} </h3>
        <div className="settings__slider">
          <Slider
            min={settings.minBreakInterval->Belt.Int.toFloat}
            max={settings.maxBreakInterval->Belt.Int.toFloat}
            value={settings.breakInterval->Belt.Int.toFloat}
            step={settings.tickBreakInterval->Belt.Int.toFloat}
            onChange={onBreakIntervalChange}
          />
        </div>
        <p className="settings__detail"> {ui.breakIntervalMsg->React.string} </p>
      </section>
      <section className="settings__section">
        <h3> {React.string("Break duration")} </h3>
        <div className="settings__slider">
          <Slider
            min={settings.minBreakDuration->Belt.Int.toFloat}
            max={settings.maxBreakDuration->Belt.Int.toFloat}
            value={settings.breakDuration->Belt.Int.toFloat}
            step={settings.tickBreakDuration->Belt.Int.toFloat}
            onChange={onBreakDurationChange}
          />
        </div>
        <p className="settings__detail"> {ui.breakDurationMsg->React.string} </p>
      </section>
    </div>
  </Window>
}
