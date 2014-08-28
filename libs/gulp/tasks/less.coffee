less = require "gulp-less"
minifyCss = require "gulp-minify-css"

SRC = "app/public/less/**/*.less"
DEST = "public/css"

lessOptions = {
    sourceMap : !global.isProduction
}

gulp.task "less", (callback) ->
    gulp.src SRC
    .pipe changed(DEST)
    .pipe less(lessOptions)
    .on "error", (error) ->
        callback error
    .pipe gulpif(global.isProduction, minifyCss ({ keepSpecialComments : 0 }))
    .pipe gulp.dest(DEST)


