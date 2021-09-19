// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as Belt_Array from "rescript/lib/es6/belt_Array.js";
import * as Belt_Option from "rescript/lib/es6/belt_Option.js";
import * as Translate$Web from "../Translate/Translate.bs.js";

function Time(Props) {
  var hours = Props.hours;
  var minutes = Props.minutes;
  var seconds = Props.seconds;
  var match = Translate$Web.useTranslation(undefined);
  var t1 = match.t1;
  var timeString = function (key, time) {
    return Belt_Option.map(Belt_Option.flatMap(time, (function (time) {
                      if (time > 0) {
                        return time;
                      }
                      
                    })), (function (time) {
                  return Curry._2(t1, key, {
                              count: time
                            });
                }));
  };
  return Belt_Array.keepMap([
                timeString("TIME.HOURS", hours),
                timeString("TIME.MINUTES", minutes),
                timeString("TIME.SECONDS", seconds)
              ], (function (time) {
                  return time;
                })).join(" ");
}

var make = Time;

export {
  make ,
  
}
/* Translate-Web Not a pure module */
