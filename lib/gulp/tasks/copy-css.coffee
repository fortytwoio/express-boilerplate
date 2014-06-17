DEST = "public/css/"
gulp.task "copy:css", ->
    gulp.src "webapps/MAIN/public/css/**/*"
    .pipe changed(DEST)
    .pipe gulp.dest(DEST)
