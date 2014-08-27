gulp.task "watch:less", ->
    # do not use path starting with './' when you also use file globs. Does not work correctly
    gulp.watch "app/public/less/**/*.less", [ "less" ]
