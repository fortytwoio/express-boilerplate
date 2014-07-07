gulp = require "gulp"
gutil = require "gulp-util"
changed = require "gulp-changed"
gulpif = require "gulp-if"
concat = require "gulp-concat"
path = require "path"
fs = require "fs"
rev = require "gulp-rev"
livereload = require "gulp-livereload"
Notification = require "node-notifier"
util = require "util"

sendNotifications = true
doLivereload = true

if process.env.GULP_NOTIFY
    gulpNotify = process.env.GULP_NOTIFY.toLowerCase()
    if gulpNotify == "n" or gulpNotify == "no" or gulpNotify == "false" then sendNotifications = false

if process.env.GULP_LIVERELOAD
    dlr = process.env.GULP_LIVERELOAD.toLowerCase()
    if dlr == "n" or dlr == "no" or dlr == "false" then doLivereload = false


# We set some gulp plugins as globals, for easier gulp task configuration and setup
global.gulp = gulp
global.gutil = gutil
global.concat = concat
global.changed = changed
global.gulpif = gulpif
global.livereload = livereload
global.util = util
global.rev = rev

# You can use this global function in .on "error" callbacks for instance
global.notify = (options) ->
    if !sendNotifications then return true
    unless options.title then options.title = "Gulp Notification"
    unless options.message then options.message = ""
    notification = new Notification()
    return notification.notify(options)


# You can use this global function if you want to get notified on changes which triggers a pagereload in livereload
global.notifyChanged = (changed) ->
    if doLivereload then livereload.changed.apply this, changed
    notify {
        title : "Gulp: Changed"
        message : "#{changed.path}"
        open : "file://#{changed.path}"
    }

global.isWatching = false
global.sendNotifications = sendNotifications
global.doLivereload = doLivereload

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

