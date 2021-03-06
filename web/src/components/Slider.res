@module("./Slider.css")
external styles: {..} = "default"

@module("rc-slider") @react.component
external make: (
  ~value: float=?,
  ~onChange: float => unit=?,
  ~min: float=?,
  ~max: float=?,
  ~step: float=?,
) => React.element = "default"
