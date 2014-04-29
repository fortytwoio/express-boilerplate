app = require "../"
projectName = app.get 'project_name'
debug = require("debug")("#{projectName}:app:controllers:test")

exports.index = (request, response) ->
  debug "requested test/index", request.query
  response.render "test"

exports.getFoo = (request, response) ->
  debug "app,mountpath", request.app.mountpath
  debug "response.locals.baseurl", response.locals.baseurl
  debug "route", request.route
  debug "request.path", request.path
  debug "app.path.path", request.app.path()
  response.render "test/foo"


