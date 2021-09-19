# Exercise Timer :watch:

Long working sessions could affect your health. Take a break ⏲️

> Project made with ❤️, ReScript, Electron and React. Contributions are welcome


# Table of Contents

* [How it works](#how-it-works)
* [How to install](#how-to-install)
* [Development](#development)

# <a name="how-it-works"></a>How it works

### Blocking windows
This app sits in a tray and when time comes to take a break it'll create blocking windows on all your screens.

![Blocking Window](https://github.com/DeH4er/exercise-timer/blob/458c73cd616f090a401d464f0f83ddae820bde22/.github/blocking-window.png)

You may want to stretch or exercise during this time. When your break is finished, app will schedule next break.

### Settings
You can adjust your break timings under settings

![Settings Window](https://github.com/DeH4er/exercise-timer/blob/458c73cd616f090a401d464f0f83ddae820bde22/.github/settings-window.png)

# <a name="how-to-install"></a>How to install

Currently, this repo doesn't have a compiled installer. But you may make an installer yourself. Please, refer to [How to dist](#how-to-dist) section

# <a name="development"><a/>Development

### How to run

```bash
npm run compile
npm run build-watch
npm start
```

### <a name="how-to-dist"></a>How to dist

```bash
npm run compile
npm run build
npm run dist
```

You'll find an installer under `dist` folder.

### How to debug

Currently, there's only a vscode launch config for debugging electron's main process. Renderer process can be debugged via dev tools + react debugger.
