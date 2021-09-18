const path = require("path");

const { env } = process;

const isProduction = env.NODE_ENV === "production";

module.exports = {
  entry: "./src/Main.bs.js",
  target: "electron-main",
  devtool: isProduction ? undefined : "inline-source-map",
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
