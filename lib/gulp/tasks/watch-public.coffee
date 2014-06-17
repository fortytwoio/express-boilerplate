gulp.task "watch:public", ->
    gulp.watch "public/**/*"
    .on "change", livereload.changed
