gulp = require "gulp"
gutil = require "gulp-util"
changed = require "gulp-changed"
concat = require "gulp-concat"
path = require "path"
fs = require "fs"
handleErrors = require "./util/handleErrors"

# We set some globals for easier gulp tasks setup
global.gulp = gulp
global.gutil = gutil
global.concat = concat
global.path = path
global.fs = fs
global.changed = changed
global.handleErrors = handleErrors
global.isWatching = false

gulpTasksDir = path.resolve __dirname, "tasks"
tasks = fs.readdirSync gulpTasksDir
tasks.forEach (taskFile) ->
  require "#{gulpTasksDir}/#{taskFile}"

