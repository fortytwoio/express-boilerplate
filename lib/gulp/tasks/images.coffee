imagemin = require "gulp-imagemin"

module.exports = () ->
  src = "./webapps/MAIN/public/img/**/*.*"
  dest = "./public/img"

  gulp
  .src src
  .pipe changed(dest)
  .pipe imagemin()
  .pipe gulp.dest(dest)
