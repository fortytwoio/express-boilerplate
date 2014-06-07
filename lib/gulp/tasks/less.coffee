less = require "gulp-less"

module.exports = ()->
  src = "./webapps/MAIN/public/less/**/*.less"
  dest = "./public/css"

  gulp
  .src src
  .pipe changed(dest)
  .pipe less
    sourceMap: true
  .pipe gulp.dest dest

