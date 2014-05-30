less = require "gulp-less"

gulp.task "less", () ->
  gulp.src "public/less/**/*.less"
  .pipe less
    paths:     [ "public/less/includes"]
    sourceMap: true
  .pipe gulp.dest "public/css"

