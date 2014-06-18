gulp.task "watch:public", ->
    gulp.watch "public/**/*"
    .on "change", notifyChanged
