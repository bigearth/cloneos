var webpack = require('webpack');
var resolve = require('path').resolve;

module.exports = {
  resolve: {
    alias: {
      'react': 'react-lite',
      'react-dom': 'react-lite'
    },
    extensions: [".js", ".ts", ".json", ".tsx", ".css", ".scss"]
  },
  entry: "./web/ts/entry.tsx",
  devtool: "source-map",
  output: {
    path: resolve("./priv/static/"),
    filename: "bundle.js",
    publicPath: "/",
  },
  module: {
    rules: [
      { test: /\.tsx?$/, loader: "ts-loader" }
    ]
  }
}
