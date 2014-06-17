DEST = "public/"
gulp.task "copy:other", ->
    gulp.src "webapps/MAIN/public/*.*"
    .pipe changed(DEST)
    .pipe gulp.dest(DEST)
