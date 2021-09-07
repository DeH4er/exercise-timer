@module("./index.css")
external styles: {..} = "default"

@module("./colors.css")
external styles: {..} = "default"

switch ReactDOM.querySelector("#root") {
| Some(root) =>
  ReactDOM.render(<React.StrictMode> <Theme> <App /> </Theme> </React.StrictMode>, root)
| None => ()
}
