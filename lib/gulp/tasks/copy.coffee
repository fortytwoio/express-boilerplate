gulp.task "copy", (callback)->
  gulp.src "./webapps/MAIN/public/css/**"
  .pipe gulp.dest("./public/css/")

  gulp.src "./webapps/MAIN/public/js/**"
  .pipe gulp.dest("./public/js/")

  callback()
