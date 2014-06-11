gulp = require "gulp"
gutil = require "gulp-util"
changed = require "gulp-changed"
gulpif = require "gulp-if"
concat = require "gulp-concat"
path = require "path"
fs = require "fs"

# We set some gulp plugins as globals, for easier gulp task configuration and setup
global.gulp = gulp
global.gutil = gutil
global.concat = concat
global.changed = changed
global.gulpif = gulpif

global.isWatching = false

# You can set NODE_ENV=(production|developemtn) and you can overwrite this with --type (production|development) argument
# when calling gulp cli. Default: development
isNodeEnvProduction = process.env.NODE_ENV?.toLowerCase() == "production" or false
global.isProduction = gutil.env?.type?.toLowerCase() == "production" or isNodeEnvProduction or false
global.environment = if isProduction then "production" else "development"

gutil.log "Starting Build in '#{gutil.colors.cyan(environment)}' mode"

gulpTasksDir = path.resolve __dirname, "tasks"
tasks = fs.readdirSync gulpTasksDir
tasks.forEach (taskFile) ->
    require "#{gulpTasksDir}/#{taskFile}"

