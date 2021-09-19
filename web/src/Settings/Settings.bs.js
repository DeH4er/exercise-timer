// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";
import * as Slider$Web from "../components/Slider.bs.js";
import * as Window$Web from "../Window/Window.bs.js";
import * as Command$Web from "../Interop/Command.bs.js";
import * as Time$Shared from "shared/src/Time.bs.js";
import SettingsCss from "./Settings.css";
import * as Settings$Shared from "shared/src/Settings.bs.js";

function settingsReducer(state, action) {
  switch (action.TAG | 0) {
    case /* LoadComplete */0 :
        return action._0;
    case /* SetBreakInterval */1 :
        return {
                maxBreakInterval: state.maxBreakInterval,
                minBreakInterval: state.minBreakInterval,
                tickBreakInterval: state.tickBreakInterval,
                breakInterval: action._0,
                maxBreakDuration: state.maxBreakDuration,
                minBreakDuration: state.minBreakDuration,
                tickBreakDuration: state.tickBreakDuration,
                breakDuration: state.breakDuration
              };
    case /* SetBreakDuration */2 :
        return {
                maxBreakInterval: state.maxBreakInterval,
                minBreakInterval: state.minBreakInterval,
                tickBreakInterval: state.tickBreakInterval,
                breakInterval: state.breakInterval,
                maxBreakDuration: state.maxBreakDuration,
                minBreakDuration: state.minBreakDuration,
                tickBreakDuration: state.tickBreakDuration,
                breakDuration: action._0
              };
    
  }
}

function uiReducer(state, action) {
  switch (action.TAG | 0) {
    case /* LoadComplete */0 :
        var settings = action._0;
        return {
                breakIntervalMsg: Time$Shared.millisToString(settings.breakInterval),
                breakDurationMsg: Time$Shared.millisToString(settings.breakDuration)
              };
    case /* SetBreakInterval */1 :
        return {
                breakIntervalMsg: Time$Shared.millisToString(action._0),
                breakDurationMsg: state.breakDurationMsg
              };
    case /* SetBreakDuration */2 :
        return {
                breakIntervalMsg: state.breakIntervalMsg,
                breakDurationMsg: Time$Shared.millisToString(action._0)
              };
    
  }
}

function reducer(state, action) {
  return {
          settings: settingsReducer(state.settings, action),
          ui: uiReducer(state.ui, action)
        };
}

function Settings(Props) {
  var match = React.useReducer(reducer, {
        settings: Settings$Shared.$$default,
        ui: {
          breakIntervalMsg: "",
          breakDurationMsg: ""
        }
      });
  var dispatch = match[1];
  var match$1 = match[0];
  var ui = match$1.ui;
  var settings = match$1.settings;
  React.useEffect((function () {
          var listener = Command$Web.on(function (cmd) {
                if (typeof cmd === "number" || cmd.TAG !== /* ReturnSettings */0) {
                  return ;
                } else {
                  return Curry._1(dispatch, {
                              TAG: /* LoadComplete */0,
                              _0: cmd._0
                            });
                }
              });
          Command$Web.send(/* GetSettings */2);
          return (function (param) {
                    return Command$Web.removeListener(listener);
                  });
        }), []);
  var onBreakIntervalChange = function (value) {
    Command$Web.send({
          TAG: /* SetBreakInterval */2,
          _0: value | 0
        });
    return Curry._1(dispatch, {
                TAG: /* SetBreakInterval */1,
                _0: value | 0
              });
  };
  var onBreakDurationChange = function (value) {
    Command$Web.send({
          TAG: /* SetBreakDuration */1,
          _0: value | 0
        });
    return Curry._1(dispatch, {
                TAG: /* SetBreakDuration */2,
                _0: value | 0
              });
  };
  return React.createElement(Window$Web.make, {
              children: React.createElement("div", {
                    className: "settings"
                  }, React.createElement("section", {
                        className: "settings__section"
                      }, React.createElement("h3", undefined, "Break interval"), React.createElement("div", {
                            className: "settings__slider"
                          }, React.createElement(Slider$Web.make, {
                                value: settings.breakInterval,
                                onChange: onBreakIntervalChange,
                                min: settings.minBreakInterval,
                                max: settings.maxBreakInterval,
                                step: settings.tickBreakInterval
                              })), React.createElement("p", {
                            className: "settings__detail"
                          }, ui.breakIntervalMsg)), React.createElement("section", {
                        className: "settings__section"
                      }, React.createElement("h3", undefined, "Break duration"), React.createElement("div", {
                            className: "settings__slider"
                          }, React.createElement(Slider$Web.make, {
                                value: settings.breakDuration,
                                onChange: onBreakDurationChange,
                                min: settings.minBreakDuration,
                                max: settings.maxBreakDuration,
                                step: settings.tickBreakDuration
                              })), React.createElement("p", {
                            className: "settings__detail"
                          }, ui.breakDurationMsg))),
              title: "Settings",
              maximize: false
            });
}

var make = Settings;

export {
  make ,
  
}
/*  Not a pure module */
