const { contextBridge, ipcRenderer } = require("electron");
contextBridge.exposeInMainWorld("electron", {
  ipcRenderer: {
    send: (channel, ...args) => ipcRenderer.send(channel, ...args),
    on: (channel, listener) => {
      ipcRenderer.on(channel, (event, ...args) => {
        listener(event, ...args);
      });
    },
  },
});
