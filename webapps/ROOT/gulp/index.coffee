gulp = require "gulp"
gutil = require "gulp-util"
path = require "path"
fs = require "fs"

# We set this as globals for all gulp tasks
global.gulp = gulp
global.gutil = gutil
global.path = path
global.fs = fs

gulpTasksDir = path.resolve __dirname, "tasks"
tasks = fs.readdirSync gulpTasksDir
tasks.forEach (task)->
  gutil.log "Requiring task file '#{gutil.colors.magenta task}'"
  require "#{gulpTasksDir}/#{task}"
