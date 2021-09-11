// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as Electron from "./Interop/Electron.bs.js";
import * as Belt_Option from "rescript/lib/es6/belt_Option.js";
import * as Command$Shared from "shared/src/Command.bs.js";
import * as Caml_splice_call from "rescript/lib/es6/caml_splice_call.js";

function on(listener) {
  return Electron.IpcMain.on("main", (function ($$event, args) {
                Belt_Option.map(Command$Shared.decodeCommand(args), (function (cmd) {
                        return Curry._2(listener, $$event, cmd);
                      }));
                
              }));
}

function send(command, webContents) {
  Caml_splice_call.spliceObjApply(webContents, "send", [
        "main",
        Command$Shared.encodeCommand(command)
      ]);
  
}

function reply($$event, command) {
  Caml_splice_call.spliceObjApply($$event, "reply", [
        "main",
        Command$Shared.encodeCommand(command)
      ]);
  
}

export {
  on ,
  send ,
  reply ,
  
}
/* Electron Not a pure module */
