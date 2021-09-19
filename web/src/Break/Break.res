@module("./Break.css")
external styles: {..} = "default"

type state = {
  breakTime: int,
  settings: Shared.Settings.t,
  remainingText: string,
}

type action = SetBreakTime(int) | SetSettings(Shared.Settings.t)

let getRemainingText: (int, int) => string = (breakTime, breakDuration) => {
  (breakDuration - breakTime)->Shared.Time.millisToString(())
}

let reducer: (state, action) => state = (state, action) => {
  switch action {
  | SetBreakTime(breakTime) => {
      ...state,
      breakTime: breakTime,
      remainingText: getRemainingText(breakTime, state.settings.breakDuration),
    }
  | SetSettings(settings) => {
      ...state,
      settings: settings,
      remainingText: getRemainingText(state.breakTime, settings.breakDuration),
    }
  }
}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(
    reducer,
    {breakTime: 0, settings: Shared.Settings.default, remainingText: ""},
  )

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
        <div className="break__remaining-text"> {state.remainingText->React.string} </div>
      </div>
    </div>
  </Window>
}
