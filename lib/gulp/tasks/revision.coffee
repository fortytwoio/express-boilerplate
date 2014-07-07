rev = require "gulp-rev"
path = require "path"

gulp.task "revision", ->
    gulp.src [ "public/**/*.*" ], { base : path.join(process.cwd(), 'public') }
    .pipe rev()
    .pipe gulp.dest("public")
    .pipe rev.manifest()
    .pipe gulp.dest("tmp")
