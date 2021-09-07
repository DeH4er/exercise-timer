@module("./Window.css")
external styles: {..} = "default"

let onMinimize = () => WebCommand.sendCommand(Command.MinimizeWindow)
let onMaximize = () => ()
let onClose = () => WebCommand.sendCommand(Command.CloseWindow)

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