clean = require "gulp-clean"
SRC = "public/**"

gulp.task "clean", ()->
    gulp.src SRC
    .pipe clean
              read :  false
              force : true
