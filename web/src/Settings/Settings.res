@module("./Settings.css")
external styles: {..} = "default"

@react.component
let make = () => {
  <Window title="Settings" maximize=false>
    <div className="settings">
      <section className="settings__section">
        <h3>{React.string("Break interval")}</h3>
        <div className="settings__slider">
          <Slider />
        </div>
        <p className="settings__detail">{React.string("2 hours 30 minutes")}</p>
      </section>
      <section className="settings__section">
        <h3>{React.string("Break duration")}</h3>
        <div className="settings__slider">
          <Slider />
        </div>
        <p className="settings__detail">{React.string("30 minutes")}</p>
      </section>
    </div>
  </Window>
}