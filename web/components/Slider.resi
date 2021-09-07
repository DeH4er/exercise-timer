@react.component
let make: (
  ~value: float=?,
  ~onChange: float => unit=?,
  ~min: float=?,
  ~max: float=?,
) => React.element
