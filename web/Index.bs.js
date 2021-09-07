// Generated by ReScript, PLEASE EDIT WITH CARE

import * as App from "./App/App.bs.js";
import * as Theme from "./Theme/Theme.bs.js";
import * as React from "react";
import * as ReactDom from "react-dom";
import IndexCss from "./index.css";
import ColorsCss from "./colors.css";

var styles = ColorsCss;

var root = document.querySelector("#root");

if (!(root == null)) {
  ReactDom.render(React.createElement(React.StrictMode, {
            children: React.createElement(Theme.make, {
                  children: React.createElement(App.make, {})
                })
          }), root);
}

export {
  styles ,
  
}
/*  Not a pure module */
