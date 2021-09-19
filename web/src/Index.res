@module("./css/index.css")
external styles: {..} = "default"

Translate.init()->ignore
Translate.listenChange()->ignore

switch ReactDOM.querySelector("#root") {
| Some(root) =>
  ReactDOM.render(<React.StrictMode> <Theme> <App /> </Theme> </React.StrictMode>, root)
| None => ()
}
