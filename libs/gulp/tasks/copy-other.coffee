DEST = 'public/'
gulp.task 'copy:other', ->
    gulp.src [ 'app/public/*.*' ]
    .pipe changed(DEST)
    .pipe gulp.dest(DEST)
