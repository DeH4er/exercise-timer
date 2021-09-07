type extension

@module("electron-devtools-installer")
external reactDevtools: extension = "REACT_DEVELOPER_TOOLS"

@module("electron-devtools-installer")
external installExtension: extension => Promise.t<string> = "default"