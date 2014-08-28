gulp.task 'watch:coffee', ->
    # do not use path starting with './' when you also use file globs. Does not work correctly
    gulp.watch [
        'app/controllers/**/*',
        'app/controllers/',
        'app/controllers/**',
        'app/models/**/*',
        'app/models/',
        'app/models/**',
        'app/routers/**/*',
        'app/routers/',
        'app/routers/**',
        'app/middlewares/**/*',
        'app/middlewares/',
        'app/middlewares/**',
        'app/libs/**/*',
        'app/libs/',
        'app/libs/**',
    ], [ 'test' ]
