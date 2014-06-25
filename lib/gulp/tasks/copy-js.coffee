DEST = "public/js/"
gulp.task "copy:js", ->
    gulp.src "webapps/MAIN/public/js/**/*.js"
    .pipe changed(DEST)
    .pipe gulp.dest(DEST)
