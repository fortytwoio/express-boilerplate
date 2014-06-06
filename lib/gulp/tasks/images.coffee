imagemin = require "gulp-imagemin"

module.exports = () ->
  src = "public/images/**"
  dest = "build/images"

  gulp
  .src src
  .pipe changed(dest)
  .pipe imagemin()
  .pipe gulp.dest(dest)
