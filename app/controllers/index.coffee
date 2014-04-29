###
GET     /                 ->  exports.index
GET     /new              ->  exports.new
POST    /                 ->  exports.create
GET     /:id              ->  exports.show
GET     /:id/edit         ->  exports.edit
PUT     /:id              ->  exports.update
DELETE  /:id              ->  exports.destroy
###

app = require "../"
projectName = app.get 'project_name'
debug = require("debug")("#{projectName}:app:controllers:index")


exports.index = (request, response) ->
  debug "Requested index"
  response.render "index"

exports.new = (request, response) ->
  debug "Requested index/new"
  response.render "index/new"


