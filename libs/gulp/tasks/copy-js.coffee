DEST = 'public/js/'
gulp.task 'copy:js', ->
    gulp.src [ 'app/public/js/**/*']
    .pipe changed(DEST)
    .pipe gulp.dest(DEST)
