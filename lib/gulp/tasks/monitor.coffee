nodemon = require "gulp-nodemon"

gulp.task "monitor", ->
    nodemon
        script :  "./"
        ext :     "coffee js json"
        verbose : false
        watch :   [
            "webapps/**/"
            "./lib/"
            "./config/"
            "./package.json"
            "./index.js"
        ]
        ignore :  [
            "webapps/*/public/"
            "./lib/gulp/"
        ]
    .on "restart", [ "build" ]

