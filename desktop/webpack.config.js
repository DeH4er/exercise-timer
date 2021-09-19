const path = require("path");

const { env } = process;

const isDevelopment = env.NODE_ENV === "development";

module.exports = {
  entry: "./src/Main.bs.js",
  target: "electron-main",
  mode: isDevelopment ? "development" : "production",
  devtool: isDevelopment ? "inline-source-map" : undefined,
  output: {
    filename: "desktop.js",
    path: path.resolve(__dirname, "..", "build"),
  },
  node: {
    __dirname: false,
    __filename: false,
  },
  module: {
    rules: [
      {
        test: /\.m?js$/,
        exclude: /(node_modules|bower_components)/,
        use: {
          loader: "babel-loader",
          options: {
            presets: ["@babel/preset-env"],
          },
        },
      },
    ],
  },
};
