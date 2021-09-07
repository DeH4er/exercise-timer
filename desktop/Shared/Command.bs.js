// Generated by ReScript, PLEASE EDIT WITH CARE


function decodeCommand(args) {
  if (args.length !== 1) {
    return ;
  }
  var match = args[0];
  switch (match) {
    case "closeWindow" :
        return /* CloseWindow */0;
    case "minimizeWindow" :
        return /* MinimizeWindow */1;
    default:
      return ;
  }
}

function encodeCommand(command) {
  if (command) {
    return ["minimizeWindow"];
  } else {
    return ["closeWindow"];
  }
}

export {
  decodeCommand ,
  encodeCommand ,
  
}
/* No side effect */
