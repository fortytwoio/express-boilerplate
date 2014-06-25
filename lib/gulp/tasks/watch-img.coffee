gulp.task "watch:img", ->
    # do not use path starting with './' when you also use file globs. Does not work correctly
    gulp.watch "webapps/*/public/img/**/*", [ "images" ]
