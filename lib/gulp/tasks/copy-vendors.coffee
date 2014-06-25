DEST = "public/vendors/"
gulp.task "copy:vendors", ->
    gulp.src "webapps/MAIN/public/vendors/**/*"
    .pipe changed(DEST)
    .pipe gulp.dest(DEST)
