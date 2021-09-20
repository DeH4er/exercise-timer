// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as Belt_Array from "rescript/lib/es6/belt_Array.js";
import * as Caml_array from "rescript/lib/es6/caml_array.js";
import * as Caml_option from "rescript/lib/es6/caml_option.js";

var Timer = {};

function rest(f) {
  return function () {
    return Curry._1(f, arguments);
  };
}

function rest2(f) {
  return function () {
    var args = arguments;
    var arg0 = Caml_array.get(args, 0);
    var rest = Belt_Array.slice(args, 1, args.length);
    return Curry._2(f, arg0, rest);
  };
}

function resultToOption(res) {
  if (res.TAG === /* Ok */0) {
    return Caml_option.some(res._0);
  }
  console.log(res._0);
  
}

export {
  Timer ,
  rest ,
  rest2 ,
  resultToOption ,
  
}
/* No side effect */
