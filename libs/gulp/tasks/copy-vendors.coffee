DEST = 'public/vendors/'
gulp.task 'copy:vendors', ->
    gulp.src [ 'app/public/vendors/**/*']
    .pipe changed(DEST)
    .pipe gulp.dest(DEST)
