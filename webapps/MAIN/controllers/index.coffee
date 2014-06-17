###
GET     /                 ->  exports.index
GET     /new              ->  exports.new
POST    /                 ->  exports.create
GET     /:id              ->  exports.show
GET     /:id/edit         ->  exports.edit
PUT     /:id              ->  exports.update
DELETE  /:id              ->  exports.destroy
###

root = require.main.exports
debug = root.get("debug")(__filename)

exports.index = (request, response) ->
    debug "Requested index"
    response.render "index"

exports.new = (request, response) ->
    debug "Requested index/new"
    response.render "index/new"

exports.show = (request, response) ->
    debug "Show item with '#{request.params.id}'"
    response.render "index/new"

