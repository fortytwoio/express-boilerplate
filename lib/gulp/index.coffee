gulp = require "gulp"
gutil = require "gulp-util"
changed = require "gulp-changed"
concat = require "gulp-concat"
path = require "path"
fs = require "fs"
handleErrors = require "./util/handleErrors"

# We set some globals for all gulp tasks
global.gulp = gulp
global.gutil = gutil
global.path = path
global.fs = fs
global.changed = changed
global.handleErrors = handleErrors

gulpTasksDir = path.resolve __dirname, "tasks"
tasks = fs.readdirSync gulpTasksDir
tasks.forEach (taskFile) ->
  taskName = path.basename taskFile, path.extname(taskFile)
  .toLowerCase()
  gutil.log "Adding Task '#{gutil.colors.magenta taskName}'"

  # Every task in 'tasks/' gets added as task with its name set to the filename
  gulp.task taskName, require "#{gulpTasksDir}/#{taskFile}"

