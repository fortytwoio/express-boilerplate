coffeelint = require "gulp-coffeelint"

gulp.task "coffeelint", (callback) ->
    gulp.src [ "webapps/*/**/*.coffee", "!webapps/*/public/vendors/**", "lib/**/*.coffee" ]
    .pipe coffeelint("./coffeelint.json")
    .pipe coffeelint.reporter()
    .pipe coffeelint.reporter("fail")
    .on "error", (error) ->
        notify {
            title : "CoffeeLint: #{error.name}"
            message : error.message
        }
        callback error
