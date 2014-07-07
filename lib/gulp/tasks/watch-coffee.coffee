gulp.task "watch:coffee", ->
    # do not use path starting with './' when you also use file globs. Does not work correctly
    gulp.watch [ "webapps/*/**/*.coffee", "!webapps/*/public/vendors/**", "lib/**/*.coffee" ], [ "test", "coffeelint" ]
