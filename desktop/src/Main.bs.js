// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Path from "path";
import * as Curry from "rescript/lib/es6/curry.js";
import * as Paths from "./Paths.bs.js";
import * as Command from "./Command.bs.js";
import * as Js_math from "rescript/lib/es6/js_math.js";
import * as Caml_obj from "rescript/lib/es6/caml_obj.js";
import * as Electron from "./Interop/Electron.bs.js";
import * as Settings from "./Settings.bs.js";
import * as Electron$1 from "electron";
import * as Belt_Option from "rescript/lib/es6/belt_Option.js";
import * as Caml_option from "rescript/lib/es6/caml_option.js";
import * as Settings$Shared from "shared/src/Settings.bs.js";
import * as ElectronDevtoolsInstaller from "electron-devtools-installer";
import ElectronDevtoolsInstaller$1 from "electron-devtools-installer";

var appState = {
  tray: undefined,
  settingsWindow: undefined,
  breakWindows: undefined,
  settings: undefined,
  breakTime: 0,
  tip: 0
};

function createWindow(createProps, startupUrl, param) {
  var defaultProps = {
    frame: false,
    webPreferences: {
      preload: Path.resolve(Paths.scriptsPath, "windowPreload.js"),
      nativeWindowOpen: true
    }
  };
  var $$window = new Electron$1.BrowserWindow(Curry._1(Electron.BrowserWindow.CreatePropsUtils.merge, [
            defaultProps,
            createProps
          ]));
  var url = Paths.webPath + "#" + startupUrl;
  $$window.loadURL(url);
  if (!Electron$1.app.isPackaged) {
    $$window.webContents.openDevTools();
  }
  return $$window;
}

function loadSettings(param) {
  return Settings.load(undefined).then(function (res) {
              var settings;
              settings = res.TAG === /* Ok */0 ? res._0 : Settings$Shared.$$default;
              appState.settings = settings;
              return Promise.resolve(undefined);
            });
}

function exit(param) {
  Belt_Option.map(appState.settings, (function (settings) {
          return Settings.save(settings).then(function (param) {
                      Electron$1.app.quit();
                      return Promise.resolve(undefined);
                    });
        }));
  
}

function openBreakWindows(param) {
  appState.tip = Js_math.random_int(0, 3);
  appState.breakWindows = Electron$1.screen.getAllDisplays().map(function (display) {
        var horizontalPadding = display.bounds.width * 0.1;
        var verticalPadding = display.bounds.height * 0.1;
        return createWindow({
                    width: display.bounds.width - 2.0 * horizontalPadding | 0,
                    height: display.bounds.height - 2.0 * verticalPadding | 0,
                    x: display.bounds.x + horizontalPadding | 0,
                    y: display.bounds.y + verticalPadding | 0,
                    skipTaskbar: true,
                    alwaysOnTop: true
                  }, "break", undefined);
      });
  
}

function scheduleBreak(param) {
  Belt_Option.map(appState.settings, (function (settings) {
          return setTimeout((function () {
                        return startBreak(undefined);
                      }), settings.breakInterval);
        }));
  
}

function startBreakTimer(param) {
  Belt_Option.map(appState.settings, (function (settings) {
          appState.breakTime = 0;
          var interval = {
            contents: undefined
          };
          interval.contents = Caml_option.some(setInterval((function () {
                      appState.breakTime = appState.breakTime + 1000 | 0;
                      Belt_Option.map(appState.breakWindows, (function (breakWindows) {
                              return breakWindows.map(function ($$window) {
                                          return Command.send({
                                                      TAG: /* ReturnBreakTime */3,
                                                      _0: appState.breakTime
                                                    }, $$window.webContents);
                                        });
                            }));
                      if (appState.breakTime >= settings.breakDuration) {
                        Belt_Option.map(interval.contents, (function (interval) {
                                clearInterval(interval);
                                
                              }));
                        return scheduleBreakClose(undefined);
                      }
                      
                    }), 1000));
          
        }));
  
}

function startBreak(param) {
  var match = appState.breakWindows;
  if (match !== undefined) {
    return ;
  } else {
    startBreakTimer(undefined);
    return openBreakWindows(undefined);
  }
}

function scheduleBreakClose(param) {
  setTimeout((function () {
          Belt_Option.map(appState.breakWindows, (function (breakWindows) {
                  return breakWindows.map(function (prim) {
                              prim.close();
                              
                            });
                }));
          appState.breakWindows = undefined;
          return scheduleBreak(undefined);
        }), 1000);
  
}

function openSettingsWindow(param) {
  var match = appState.settingsWindow;
  if (match !== undefined) {
    return ;
  }
  var $$window = createWindow({
        width: 400,
        height: 370
      }, "settings", undefined);
  appState.settingsWindow = $$window;
  
}

function createTray(param) {
  var iconPath = Path.resolve(Paths.imgPath, "icon.png");
  var createdTray = new Electron$1.Tray(iconPath);
  appState.tray = Caml_option.some(createdTray);
  var menu = Electron$1.Menu.buildFromTemplate([
        {
          label: "Settings",
          click: openSettingsWindow
        },
        {
          label: "Exit",
          click: exit
        }
      ]);
  createdTray.setContextMenu(menu);
  
}

function installDevTools(param) {
  if (!Electron$1.app.isPackaged) {
    ElectronDevtoolsInstaller$1(ElectronDevtoolsInstaller.REACT_DEVELOPER_TOOLS);
    return ;
  }
  
}

Command.on(function ($$event, command) {
      var $$window = Electron$1.BrowserWindow.fromWebContents($$event.sender);
      if (typeof command === "number") {
        switch (command) {
          case /* CloseWindow */0 :
              $$window.close();
              Belt_Option.map(appState.settingsWindow, (function (settingsWindow) {
                      if (Caml_obj.caml_equal($$window, settingsWindow)) {
                        appState.settingsWindow = undefined;
                        return ;
                      }
                      
                    }));
              return ;
          case /* MinimizeWindow */1 :
              $$window.minimize();
              return ;
          case /* GetSettings */2 :
              Belt_Option.map(appState.settings, (function (settings) {
                      return Command.send({
                                  TAG: /* ReturnSettings */0,
                                  _0: settings
                                }, $$event.sender);
                    }));
              return ;
          case /* GetTip */3 :
              return Command.send({
                          TAG: /* ReturnTip */4,
                          _0: appState.tip
                        }, $$event.sender);
          
        }
      } else {
        switch (command.TAG | 0) {
          case /* SetBreakDuration */1 :
              var breakDuration = command._0;
              Belt_Option.map(appState.settings, (function (settings) {
                      appState.settings = {
                        maxBreakInterval: settings.maxBreakInterval,
                        minBreakInterval: settings.minBreakInterval,
                        tickBreakInterval: settings.tickBreakInterval,
                        breakInterval: settings.breakInterval,
                        maxBreakDuration: settings.maxBreakDuration,
                        minBreakDuration: settings.minBreakDuration,
                        tickBreakDuration: settings.tickBreakDuration,
                        breakDuration: breakDuration,
                        selectedLanguage: settings.selectedLanguage
                      };
                      
                    }));
              return ;
          case /* SetBreakInterval */2 :
              var breakInterval = command._0;
              Belt_Option.map(appState.settings, (function (settings) {
                      appState.settings = {
                        maxBreakInterval: settings.maxBreakInterval,
                        minBreakInterval: settings.minBreakInterval,
                        tickBreakInterval: settings.tickBreakInterval,
                        breakInterval: breakInterval,
                        maxBreakDuration: settings.maxBreakDuration,
                        minBreakDuration: settings.minBreakDuration,
                        tickBreakDuration: settings.tickBreakDuration,
                        breakDuration: settings.breakDuration,
                        selectedLanguage: settings.selectedLanguage
                      };
                      
                    }));
              return ;
          case /* ChangeLanguage */5 :
              var language = command._0;
              Belt_Option.map(appState.settings, (function (settings) {
                      appState.settings = {
                        maxBreakInterval: settings.maxBreakInterval,
                        minBreakInterval: settings.minBreakInterval,
                        tickBreakInterval: settings.tickBreakInterval,
                        breakInterval: settings.breakInterval,
                        maxBreakDuration: settings.maxBreakDuration,
                        minBreakDuration: settings.minBreakDuration,
                        tickBreakDuration: settings.tickBreakDuration,
                        breakDuration: settings.breakDuration,
                        selectedLanguage: language
                      };
                      return Electron$1.BrowserWindow.getAllWindows().map(function ($$window) {
                                  return Command.send({
                                              TAG: /* LanguageChanged */6,
                                              _0: language
                                            }, $$window.webContents);
                                });
                    }));
              return ;
          default:
            return ;
        }
      }
    });

Electron$1.app.whenReady().then(function (param) {
      installDevTools(undefined);
      return loadSettings(undefined).then(function (param) {
                  createTray(undefined);
                  scheduleBreak(undefined);
                  return Promise.resolve(undefined);
                });
    });

Electron$1.app.on("window-all-closed", (function (prim) {
        
      }));

var countOfTips = 3;

export {
  appState ,
  countOfTips ,
  createWindow ,
  loadSettings ,
  exit ,
  openBreakWindows ,
  scheduleBreak ,
  startBreakTimer ,
  startBreak ,
  scheduleBreakClose ,
  openSettingsWindow ,
  createTray ,
  installDevTools ,
  
}
/*  Not a pure module */
