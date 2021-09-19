// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as App$Web from "./App/App.bs.js";
import * as Theme$Web from "./Theme/Theme.bs.js";
import * as ReactDom from "react-dom";
import * as Translate$Web from "./Translate/Translate.bs.js";
import IndexCss from "./css/index.css";

var styles = IndexCss;

Translate$Web.init(undefined);

Translate$Web.listenChange(undefined);

var root = document.querySelector("#root");

if (!(root == null)) {
  ReactDom.render(React.createElement(React.StrictMode, {
            children: React.createElement(Theme$Web.make, {
                  children: React.createElement(App$Web.make, {})
                })
          }), root);
}

export {
  styles ,
  
}
/* styles Not a pure module */
