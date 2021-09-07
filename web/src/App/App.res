@module("./App.css")
external styles: {..} = "default"

@react.component
let make = () => {
    let url = RescriptReactRouter.useUrl()

    switch url.hash {
      | "break" => <Break />
      | "settings" => <Settings />
      | _ => <div>{React.string("Page not found")}</div>
    }
}