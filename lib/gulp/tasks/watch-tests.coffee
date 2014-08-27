gulp.task "watch:tests", ->
    # do not use path starting with './' when you also use file globs. Does not work correctly
    gulp.watch [ "tests/**/*", "app/tests/**/*" ], [ "test" ]
