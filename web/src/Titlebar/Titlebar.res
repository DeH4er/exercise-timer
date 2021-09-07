@module("./Titlebar.css")
external styles: {..} = "default"

@react.component
let make = (
  ~title: string,
  ~minimize=true,
  ~maximize=true,
  ~close=true,
  ~onMinimize=() => (),
  ~onMaximize=() => (),
  ~onClose=() => (),
) => {
  <div className="titlebar">
    <div className="titlebar__title"> {React.string(title)} </div>
    <div className="titlebar__actions">
      {minimize
        ? <div className="titlebar__action titlebar__minimize" onClick={(_) => onMinimize()}>
            <FeatherIcon.Minus size=15/>
          </div>
        : <> </>}
      {maximize
        ? <div className="titlebar__action titlebar__maximize" onClick={(_) => onMaximize()}>
            <FeatherIcon.Square size=12/>
          </div>
        : <> </>}
      {close
        ? <div className="titlebar__action titlebar__close" onClick={(_) => onClose()}>
            <FeatherIcon.X size=15/>
          </div>
        : <> </>}
    </div>
  </div>
}
