@module("./Window.css")
external styles: {..} = "default"

let onMinimize = () => Command.send(Shared.Command.MinimizeWindow)
let onMaximize = () => ()
let onClose = () => Command.send(Shared.Command.CloseWindow)

@react.component
let make = (
  ~children: React.element,
  ~title: string="",
  ~minimize=true,
  ~maximize=true,
  ~close=true,
  ~titlebar=true,
) => {
  <div className="window">
    {titlebar ? <Titlebar title maximize minimize close onMinimize onMaximize onClose /> : <> </>}
    <div className=`window__content ${titlebar ? "" : "window__content--no-titlebar"}`> {children} </div>
  </div>
}
