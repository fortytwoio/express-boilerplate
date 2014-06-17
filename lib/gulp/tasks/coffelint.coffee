coffeelint = require "gulp-coffeelint"

gulp.task "coffeelint", ->
    gulp.src [ "**/*.coffee", "!node_modules/**" ]
    .pipe coffeelint("./coffeelint.json")
    .pipe coffeelint.reporter()
    .pipe coffeelint.reporter('fail')
