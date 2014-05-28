gulp = require "gulp"
gutil = require "gulp-util"
less = require "gulp-less"
path = require "path"

gulp.task "less", () ->
  gulp.src "./less/**/*.less"
  .pipe less
    paths:     [ path.join("..", "less", "includes")]
    sourceMap: true
  .pipe gulp.dest "./public/css"

