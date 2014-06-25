gulp.task "watch:public", ->
    gulp.watch [ "public/*/**", "!public/vendors/**" ]
    .on "change", notifyChanged
