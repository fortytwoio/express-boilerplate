browserify = require "browserify"
watchify = require "watchify"
source = require "vinyl-source-stream"

dest = "public/js/"

gulp.task "browserify", ()->
  bundleMethod = if global.isWatching then watchify else browserify

  bundler = bundleMethod
    entries: ["./webapps/MAIN/public/coffee/app.coffee"]
    extensions: [".coffee", ".js", ".json"]

  bundle = ()->
    bundler.bundle
      debug: true
    .on "error", global.handleErrors
    .pipe source("app.js")
    .pipe gulp.dest(dest)
    return bundler

  if global.isWatching then bundler.on "update", bundle

  return bundle()
