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
  let (state, dispatch) = React.useReducer(reducer, Shared.Settings.default)

  React.useEffect0(() => {
    Command.on(cmd => {
      switch cmd {
      | ReturnSettings(settings) => settings->LoadComplete->dispatch
      | _ => ()
      }
    })
    Shared.Command.GetSettings->Command.send
    None
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
            min={state.minBreakInterval->Belt.Int.toFloat}
            max={state.maxBreakInterval->Belt.Int.toFloat}
            value={state.breakInterval->Belt.Int.toFloat}
            onChange={onBreakIntervalChange}
          />
        </div>
        <p className="settings__detail"> {React.string("2 hours 30 minutes")} </p>
      </section>
      <section className="settings__section">
        <h3> {React.string("Break duration")} </h3>
        <div className="settings__slider">
          <Slider
            min={state.minBreakDuration->Belt.Int.toFloat}
            max={state.maxBreakDuration->Belt.Int.toFloat}
            value={state.breakDuration->Belt.Int.toFloat}
            onChange={onBreakDurationChange}
          />
        </div>
        <p className="settings__detail"> {React.string("30 minutes")} </p>
      </section>
    </div>
  </Window>
}
