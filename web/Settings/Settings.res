@module("./Settings.css")
external styles: {..} = "default"

@react.component
let make = () => {
  <Window title="Settings" maximize=false>
    <div className="settings">
      {React.string("Settings")}
    </div>
  </Window>
}