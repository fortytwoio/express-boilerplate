less = require "gulp-less"

SRC = "./webapps/MAIN/public/less/**/*.less"
DEST = "./public/css"

gulp.task "less", ()->
  gulp
  .src SRC
  .pipe changed(DEST)
  .pipe less
    sourceMap: true
  .pipe gulp.dest(DEST)

