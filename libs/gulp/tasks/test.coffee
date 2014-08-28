mocha = require 'gulp-mocha'
chai = require 'chai'
assert = require 'assert'

global.chai = chai
global.assert = assert

gulp.task 'test', ->
    gulp.src [ 'tests/**/*', 'app/tests/**/*' ], { read : false }
    .pipe mocha({
        reporter : 'spec',
        ui : 'bdd'
        globals : [
            'chai',
            'assert'
        ]
    })

