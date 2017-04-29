var webpack = require('webpack');
var resolve = require('path').resolve;

module.exports = {
  entry: "./web/markup/index.html",
  devtool: "source-map",
  output: {
    path: resolve("./priv/static/"),
    filename: "bundle.js",
    publicPath: "/",
  },
  module: {
    rules: [
      { test: /\.html?$/, loader: "html-loader" }
    ]
  }
}
