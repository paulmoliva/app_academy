const path = require("path");

module.exports = {
  context: __dirname,
  entry: "./frontend/twitter.js",
  output: {
    path: path.join(__dirname, 'app', 'assets', 'javascripts'),  // ==> "/Users/aastudent/desktop.w6d5/app/assets/java"
    filename: "bundle.js",
    devtoolModuleFilenameTemplate: '[resourcePath]',
    devtoolFallbackModuleFilenameTemplate: '[resourcePath]?[hash]'
  },
  devtool: 'source-maps',
};
