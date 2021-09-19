// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";
import * as Translate$Web from "../Translate/Translate.bs.js";
import * as ReactFeather from "react-feather";
import TitlebarCss from "./Titlebar.css";

function Titlebar(Props) {
  var title = Props.title;
  var minimizeOpt = Props.minimize;
  var maximizeOpt = Props.maximize;
  var closeOpt = Props.close;
  var onMinimizeOpt = Props.onMinimize;
  var onMaximizeOpt = Props.onMaximize;
  var onCloseOpt = Props.onClose;
  var minimize = minimizeOpt !== undefined ? minimizeOpt : true;
  var maximize = maximizeOpt !== undefined ? maximizeOpt : true;
  var close = closeOpt !== undefined ? closeOpt : true;
  var onMinimize = onMinimizeOpt !== undefined ? onMinimizeOpt : (function (param) {
        
      });
  var onMaximize = onMaximizeOpt !== undefined ? onMaximizeOpt : (function (param) {
        
      });
  var onClose = onCloseOpt !== undefined ? onCloseOpt : (function (param) {
        
      });
  var match = Translate$Web.useTranslation(undefined);
  return React.createElement("div", {
              className: "titlebar"
            }, React.createElement("div", {
                  className: "titlebar__title"
                }, Curry._1(match.t, title)), React.createElement("div", {
                  className: "titlebar__actions"
                }, minimize ? React.createElement("div", {
                        className: "titlebar__action titlebar__minimize",
                        onClick: (function (param) {
                            return Curry._1(onMinimize, undefined);
                          })
                      }, React.createElement(ReactFeather.Minus, {
                            size: 15
                          })) : React.createElement(React.Fragment, undefined), maximize ? React.createElement("div", {
                        className: "titlebar__action titlebar__maximize",
                        onClick: (function (param) {
                            return Curry._1(onMaximize, undefined);
                          })
                      }, React.createElement(ReactFeather.Square, {
                            size: 12
                          })) : React.createElement(React.Fragment, undefined), close ? React.createElement("div", {
                        className: "titlebar__action titlebar__close",
                        onClick: (function (param) {
                            return Curry._1(onClose, undefined);
                          })
                      }, React.createElement(ReactFeather.X, {
                            size: 15
                          })) : React.createElement(React.Fragment, undefined)));
}

var make = Titlebar;

export {
  make ,
  
}
/*  Not a pure module */
