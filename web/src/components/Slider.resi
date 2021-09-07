@react.component
let make: (
  ~value: float=?,
  ~onChange: float => unit=?,
  ~min: float=?,
  ~max: float=?,
  ~step: float=?,
) => React.element
