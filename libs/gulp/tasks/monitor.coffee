nodemon = require "gulp-nodemon"

gulp.task "monitor", ->
    nodemon {
        script : "./"
        ext : "coffee js json"
        verbose : false
        watch : [
            "app/"
            "lib/"
            "config/"
        ]
        ignore : [
            "app/public/"
            "app/tests/"
            "lib/gulp/"
        ]
    }
