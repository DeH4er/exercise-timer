let themes = ["theme1"]
let theme = themes[0]

@react.component
let make = (~children: React.element) => {
  <div className={theme}>
    {children}
  </div>
}