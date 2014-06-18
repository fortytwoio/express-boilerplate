nodemon = require "gulp-nodemon"

gulp.task "monitor", ->
    nodemon {
        script : "./"
        ext : "coffee js json"
        verbose : false
        watch : [
            "webapps/**/"
            "./lib/"
        ]
        ignore : [
            "webapps/*/public/"
            "webapps/*/tests/"
            "./lib/gulp/"
        ]
    }
    .on "restart", (files) ->
        notify {
            title : "Server restart triggered"
            message : "by: #{files.join ', '}"
            open : "http://localhost:3000"
        }
