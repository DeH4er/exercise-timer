let themes = ["dark"]
let theme = themes[0]

@react.component
let make = (~children: React.element) => {
  <div className={`theme-${theme}`}> {children} </div>
}
