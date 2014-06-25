gulp.task "watch:jade", ->
    gulp.watch "webapps/*/views/**/*.jade"
    .on "change", notifyChanged
