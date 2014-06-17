gulp.task "watch:css", ->
    # do not use path starting with './' when you also use file globs. Does not work correctly
    gulp.watch "webapps/**/public/css/**/*", [ "copy:css" ]
    return null
