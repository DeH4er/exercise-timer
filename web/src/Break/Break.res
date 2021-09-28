@module("./Break.css")
external styles: {..} = "default"

type state = {
  breakTime: int,
  tip: int,
  settings: Shared.Settings.t,
}

type action = SetBreakTime(int) | SetSettings(Shared.Settings.t) | SetTip(int)

let reducer: (state, action) => state = (state, action) => {
  switch action {
  | SetBreakTime(breakTime) => {
      ...state,
      breakTime: breakTime,
    }
  | SetTip(tip) => {
      ...state,
      tip: tip,
    }
  | SetSettings(settings) => {
      ...state,
      settings: settings,
    }
  }
}

@react.component
let make = () => {
  let {t} = Translate.useTranslation()

  let (state, dispatch) = React.useReducer(
    reducer,
    {breakTime: 0, tip: 0, settings: Shared.Settings.default},
  )

  let remainingTime = (state.settings.breakDuration - state.breakTime)->Shared.Time.millisToTime

  React.useEffect0(() => {
    let listener = Command.on(cmd => {
      switch cmd {
      | ReturnBreakTime(breakTime) => breakTime->SetBreakTime->dispatch
      | ReturnSettings(settings) => settings->SetSettings->dispatch
      | ReturnTip(tip) => tip->SetTip->dispatch
      | _ => ()
      }
    })

    GetSettings->Command.send
    GetTip->Command.send

    Some(
      () => {
        listener->Command.removeListener
      },
    )
  })

  <Window titlebar=false>
    <div className="break">
      <div className="break__title">
        {`TIP.${state.tip->Js.Int.toString}`->t->React.string}
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
