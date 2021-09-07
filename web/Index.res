%%raw(`import "rc-slider/assets/index.css";`)

@module("./css/colors.css")
external styles: {..} = "default"

@module("./css/index.css")
external styles: {..} = "default"

switch ReactDOM.querySelector("#root") {
| Some(root) =>
  ReactDOM.render(<React.StrictMode> <Theme> <App /> </Theme> </React.StrictMode>, root)
| None => ()
}
