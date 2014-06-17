less = require "gulp-less"
minifyCss = require "gulp-minify-css"

SRC = "./webapps/MAIN/public/less/**/*.less"
DEST = "./public/css"

lessOptions = {
    sourceMap : !global.isProduction
}

gulp.task "less", ->
    gulp.src SRC
    .pipe changed(DEST)
    .pipe less(lessOptions)
    .pipe concat("style.css")
    .pipe gulpif(global.isProduction, minifyCss ({ keepSpecialComments : 0 }))
    .pipe gulp.dest(DEST)
    return null

