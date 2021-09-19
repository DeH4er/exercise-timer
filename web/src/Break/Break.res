@module("./Break.css")
external styles: {..} = "default"

@react.component
let make = () => {
  <Window titlebar=false>
    <div className="break">
      <div className="break__title">
        {"Long working sessions may affect your health. Take a break"->React.string}
      </div>
      <div className="break__remaining">
        <div className="break__remaining-progress"> <ProgressBar value=55.0 /> </div>
        <div className="break__remaining-text"> {"29 minutes 54 seconds"->React.string} </div>
      </div>
    </div>
  </Window>
}
