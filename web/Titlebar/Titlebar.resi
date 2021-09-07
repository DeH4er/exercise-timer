@react.component
let make: (
  ~title: string,
  ~minimize: bool=?,
  ~maximize: bool=?,
  ~close: bool=?,
  ~onMinimize: unit => unit=?,
  ~onMaximize: unit => unit=?,
  ~onClose: unit => unit=?,
) => React.element