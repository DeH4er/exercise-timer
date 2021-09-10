@module("./Window.css")
external styles: {..} = "default"

let onMinimize = () => Command.sendCommand(Shared.Command.MinimizeWindow)
let onMaximize = () => ()
let onClose = () => Command.sendCommand(Shared.Command.CloseWindow)

@react.component
let make = (
  ~title: string,
  ~children: React.element,
  ~minimize=true,
  ~maximize=true,
  ~close=true,
  ) => {

  <div className="window">
    <Titlebar title maximize minimize close onMinimize onMaximize onClose />
    <div className="window__content">
      {children}
    </div>
  </div>
}