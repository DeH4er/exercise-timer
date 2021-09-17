let resourcesPath: string = Electron.App.isPackaged
  ? Node.Path.resolve([Node.process["resourcesPath"]])
  : Node.Path.resolve([Node.__dirname, "..", "resources"])

let imgPath: string = Node.Path.resolve([resourcesPath, "img"])
let scriptsPath: string = Node.Path.resolve([resourcesPath, "scripts"])

let webPath: string = Electron.App.isPackaged
  ? Node.Path.resolve([resourcesPath, "web", "index.html"])
  : "http://localhost:3000"
