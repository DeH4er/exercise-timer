@react.component
let make: (
  ~title: string,
  ~children: React.element,
  ~minimize:bool=?,
  ~maximize:bool=?,
  ~close:bool=?,
  ) => React.element