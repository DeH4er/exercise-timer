// Generated by ReScript, PLEASE EDIT WITH CARE

import * as $$Node from "./Node.bs.js";
import * as Path from "path";
import * as Electron from "./Electron.bs.js";
import * as Belt_Result from "rescript/lib/es6/belt_Result.js";

function getPath(key) {
  return Path.resolve(Electron.App.getPath("userData"), key + ".json");
}

function set(json, key) {
  return $$Node.Fs.writeFile(JSON.stringify(json), getPath(key));
}

function get(key) {
  return $$Node.Fs.readFile(getPath(key)).then(function (res) {
              return Promise.resolve(Belt_Result.map(res, (function (prim) {
                                return JSON.parse(prim);
                              })));
            });
}

export {
  set ,
  get ,
  
}
/* Node Not a pure module */
