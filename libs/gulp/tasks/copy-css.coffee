DEST = 'public/css/'
gulp.task 'copy:css', ->
    gulp.src [ 'app/public/css/**/*' ]
    .pipe changed(DEST)
    .pipe gulp.dest(DEST)
