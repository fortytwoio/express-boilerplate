gulp.task "watch:jade", ->
    gulp.watch "webapps/**/*.jade"
    .on "change", livereload.changed
