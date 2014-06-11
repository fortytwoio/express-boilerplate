prettyHrtime = require "pretty-hrtime"
startTime = undefined

exports.start = ->
    startTime = process.hrtime()
    gutil.log "Starting '#{gutil.colors.cyan "browserify bundle"}'..."

exports.end = ->
    taskTime = process.hrtime startTime
    prettyTime = prettyHrtime taskTime
    gutil.log "Finished '#{gutil.colors.cyan "browserify bundle" }' after #{gutil.colors.magenta(prettyTime)}"
