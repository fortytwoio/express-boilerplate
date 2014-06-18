less = require "gulp-less"
minifyCss = require "gulp-minify-css"

SRC = "webapps/MAIN/public/less/**/*.less"
DEST = "public/css"

lessOptions = {
    sourceMap : !global.isProduction
}

gulp.task "less", (callback) ->
    gulp.src SRC
    .pipe changed(DEST)
    .pipe less(lessOptions)
    .on "error", (error) ->
        notify {
            title : "gulp-less: #{error.name}"
            subtitle : "#{error.fileName}:#{error.lineNumber}"
            message : "#{error.message}"
            open : "file://#{error.fileName}"
        }
        callback error
    .pipe gulpif(global.isProduction, minifyCss ({ keepSpecialComments : 0 }))
    .pipe gulp.dest(DEST)


