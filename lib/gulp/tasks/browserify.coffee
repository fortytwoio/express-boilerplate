browserify = require "browserify"
watchify = require "watchify"
uglify = require "gulp-uglify"
streamify = require "gulp-streamify"
source = require "vinyl-source-stream"
bundleLogger = require "../util/bundlelogger"

DEST = "public/js/"

gulp.task "browserify", (callback) ->
    bundleMethod = if global.isWatching then watchify else browserify

    bundler = bundleMethod {
        entries : [ "./app/public/coffee/app.coffee" ]
        extensions : [ ".coffee", ".js", ".json", ".cjsx" ]
        bundleExternal : false
        insertGlobals : false
        detectGlobals : false
    }

    bundle = ->
        bundleLogger.start()
        bundler.bundle {
            debug : !global.isProduction
        }
        .on "error", (error) ->
            notify {
                title : "Browserify: #{error.name}"
                message : "#{error.message}"
                open : "file://#{error.parent}"
            }
            callback error
        .on "end", bundleLogger.end
        .pipe source("app.js")
        .pipe gulpif(global.isProduction, streamify(uglify()))
        .pipe gulp.dest(DEST)
        return bundler

    if global.isWatching then bundler.on "update", bundle

    return bundle()
