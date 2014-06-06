gulp = require "gulp"
gutil = require "gulp-util"
changed = require "gulp-changed"
concat = require "gulp-concat"
path = require "path"
fs = require "fs"
handleErrors = require "./util/handleErrors"
config = require "../webapps/ROOT/config/index"

# We set some globals for all gulp tasks
global.gulp = gulp
global.gutil = gutil
global.path = path
global.fs = fs
global.changed = changed
global.config = config
global.handleErrors = handleErrors

gulpTasksDir = path.resolve __dirname, "tasks"
tasks = fs.readdirSync gulpTasksDir
tasks.forEach (taskFile) ->
  taskName = path.basename taskFile, path.extname(taskFile)
  gutil.log "Adding Task '#{gutil.colors.magenta taskName}'"
  gulp.task taskName, require "#{gulpTasksDir}/#{taskFile}"

