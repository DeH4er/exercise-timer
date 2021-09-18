@react.component
let make: (
  ~children: React.element,
  ~title: string=?,
  ~minimize: bool=?,
  ~maximize: bool=?,
  ~close: bool=?,
  ~titlebar: bool=?,
) => React.element
