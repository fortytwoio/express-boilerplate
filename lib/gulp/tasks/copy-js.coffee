gulp.task "copy:js", ->
    gulp.src "webapps/MAIN/public/js/**"
    .pipe gulp.dest("public/js/")
