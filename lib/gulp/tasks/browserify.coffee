browserify = require "browserify"
watchify = require "watchify"
coffeeify = require "coffeeify"
source = require "vinyl-source-stream"

dest = "./public/js/"

module.exports = ->
  browserify
    entries: [
      "./webapps/MAIN/public/coffee/app.coffee"
    ]
    extensions: [
      ".coffee"
      ".js"
      ".json"
    ]
  .bundle
      debug: true
  .on "error", handleErrors
  .pipe source("app.js")
  .pipe gulp.dest(dest)

