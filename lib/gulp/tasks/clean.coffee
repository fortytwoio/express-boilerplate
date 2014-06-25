rimraf = require "gulp-rimraf"

SRC = [ "public/**", "public/**/*.*", "!public/", "!public/.keep" ]

gulp.task "clean", ->
    gulp.src SRC, { read : false }
    .pipe rimraf { force : true }
