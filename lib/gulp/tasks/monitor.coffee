nodemon = require "gulp-nodemon"

gulp.task "monitor", [ "test" ], ->
    nodemon {
        script : "./"
        ext : "coffee js json"
        verbose : false
        watch : [
            "app/"
            "lib/"
        ]
        ignore : [
            "app/public/"
            "app/tests/"
            "./lib/gulp/"
        ]
    }
    .on 'change', [ 'test' ]
    .on "restart", (files = []) ->
        notify {
            title : "Server restart triggered"
            message : "by: #{files.join ', '}"
            open : "http://localhost:3000"
        }
