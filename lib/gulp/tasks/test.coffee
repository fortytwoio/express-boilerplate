mocha = require "gulp-mocha"
chai = require "chai"
assert = require "assert"
util = require "util"

global.chai = chai
global.assert = assert

gulp.task "test", ->
    gulp.src [ "tests/**/*", "app/tests/**/*" ], { read : false }
    .pipe mocha({
        reporter : "spec",
        ui : "bdd"
        globals : [
            "chai",
            "assert"
        ]
    })
    .on "error", (error) ->
        notify {
            title : "#{error.plugin}: #{error.name}"
            message : "#{error.message}"
        }
