rev = require "gulp-rev"
path = require "path"
filter = require "gulp-filter"
revReplace = require "gulp-rev-replace"

cssFilter = filter "**/*.css"
gulp.task "revision", ->
    gulp.src [ "public/**/*.*" ], { base : path.join(process.cwd(), 'public') }
    .pipe rev()
    .pipe revReplace()
    .pipe gulp.dest("public")

