@module("./ProgressBar.css")
external styles: {..} = "default"

let clamp = (value, min, max) => {
  if value < min {
    min
  } else if value > max {
    max
  } else {
    value
  }
}

@react.component
let make = (~min: float=0.0, ~max: float=100.0, ~value: float) => {
  let width = (value -. min) /. (max -. min) *. 100.0
  let width = clamp(width, 0.0, 100.0)
  <div className="progress-bar">
    <div className="progress-bar__background" />
    <div className="progress-bar__foreground" style={ReactDOM.Style.make(~width=j`$width%`, ())} />
  </div>
}
