// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Electron from "electron";
import * as Props$Shared from "shared/src/Props.bs.js";
import * as Utils$Shared from "shared/src/Utils.bs.js";

function getPath(pathName) {
  return Electron.app.getPath(pathName);
}

var App = {
  getPath: getPath
};

var WebContents = {};

var WebPreferencesProps = {};

var WebPreferencesPropsUtils = Props$Shared.MakePropsUtils(WebPreferencesProps);

var CreateProps = {};

var CreatePropsUtils = Props$Shared.MakePropsUtils(CreateProps);

var BrowserWindow = {
  WebPreferencesProps: WebPreferencesProps,
  WebPreferencesPropsUtils: WebPreferencesPropsUtils,
  CreateProps: CreateProps,
  CreatePropsUtils: CreatePropsUtils
};

var CreateProps$1 = {};

var CreatePropsUtils$1 = Props$Shared.MakePropsUtils(CreateProps$1);

var Menu = {
  CreateProps: CreateProps$1,
  CreatePropsUtils: CreatePropsUtils$1
};

var Tray = {};

function on(channel, listener) {
  Electron.ipcMain.on(channel, Utils$Shared.rest2(listener));
  
}

var IpcMain = {
  on: on
};

var Display = {};

var $$Screen = {};

export {
  App ,
  WebContents ,
  BrowserWindow ,
  Menu ,
  Tray ,
  IpcMain ,
  Display ,
  $$Screen ,
  
}
/* WebPreferencesPropsUtils Not a pure module */
