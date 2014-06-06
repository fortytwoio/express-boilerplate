browserify = require "browserify"
watchify = require "watchify"
coffeeify = require "coffeeify"
source = require "vinyl-source-stream"

module.exports = ->
  browserify
    entries: ["./public/src/coffee/app.coffee"]
    extensions: [
      ".coffee"
    ]


  .bundle debug: false
  .on "error", handleErrors
  .pipe source("app.js")
  .pipe
  .pipe gulp.dest("./public/build/js/")

