gulp = require "gulp"
gutil = require "gulp-util"
fs = require "fs"

gulpTasksDir = "#{__dirname}/gulp"
tasks = fs.readdirSync gulpTasksDir
tasks.forEach (task)->
  gutil.log "Requiring task file '#{gutil.colors.magenta task}'"
  require "#{gulpTasksDir}/#{task}"


gulp.task "default", ["less"]
