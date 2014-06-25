gulp.task "watch:less", ->
    # do not use path starting with './' when you also use file globs. Does not work correctly
    gulp.watch "webapps/*/public/less/**/*.less", [ "less" ]
