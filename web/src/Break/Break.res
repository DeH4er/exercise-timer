@module("./Break.css")
external styles: {..} = "default"

type state = {
  breakTime: int,
  settings: Shared.Settings.t,
}

type action = SetBreakTime(int) | SetSettings(Shared.Settings.t)

let reducer: (state, action) => state = (state, action) => {
  switch action {
  | SetBreakTime(breakTime) => {
      ...state,
      breakTime: breakTime,
    }
  | SetSettings(settings) => {
      ...state,
      settings: settings,
    }
  }
}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(
    reducer,
    {breakTime: 0, settings: Shared.Settings.default},
  )

  let remainingTime = (state.settings.breakDuration - state.breakTime)->Shared.Time.millisToTime

  React.useEffect0(() => {
    let listener = Command.on(cmd => {
      switch cmd {
      | ReturnBreakTime(breakTime) => breakTime->SetBreakTime->dispatch
      | ReturnSettings(settings) => settings->SetSettings->dispatch
      | _ => ()
      }
    })

    GetSettings->Command.send

    Some(
      () => {
        listener->Command.removeListener
      },
    )
  })

  <Window titlebar=false>
    <div className="break">
      <div className="break__title">
        {"Long working sessions may affect your health. Take a break"->React.string}
      </div>
      <div className="break__remaining">
        <div className="break__remaining-progress">
          <ProgressBar
            max={state.settings.breakDuration->Belt.Int.toFloat}
            value={state.breakTime->Belt.Int.toFloat}
          />
        </div>
        <div className="break__remaining-text">
          <Time minutes={remainingTime.minutes} seconds={remainingTime.seconds} />
        </div>
      </div>
    </div>
  </Window>
}
