let resourcesPath: string = Electron.App.isPackaged
  ? Node.Path.join([Node.process["resourcesPath"]])
  : Node.Path.join([Node.__dirname, "..", "resources"])

let imgPath: string = Node.Path.join([resourcesPath, "img"])
let scriptsPath: string = Node.Path.join([resourcesPath, "scripts"])

let webPath: string = Electron.App.isPackaged
  ? Node.Path.join([resourcesPath, "web", "index.html"])
  : "http://localhost:3000"
