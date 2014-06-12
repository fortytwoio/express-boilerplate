gulp.task "copy:other", ->
    gulp.src "webapps/MAIN/public/*.*"
    .pipe gulp.dest("public/")
