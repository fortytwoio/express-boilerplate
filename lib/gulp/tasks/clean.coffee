clean = require "gulp-clean"
SRC = "public/**"

gulp.task "clean", ()->
  stream = gulp.src SRC
  .pipe clean
    read: false
    force: true
  return stream
