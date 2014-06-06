###
GET     /                 ->  exports.index
GET     /new              ->  exports.new
POST    /                 ->  exports.create
GET     /:id              ->  exports.show
GET     /:id/edit         ->  exports.edit
PUT     /:id              ->  exports.update
DELETE  /:id              ->  exports.destroy
###

debug = ROOT.get("debug")(__filename)
debug "Another Test Debug Message"

exports.index = (request, response) ->
  debug "Requested index"
  response.render "index"

exports.new = (request, response) ->
  debug "Requested index/new"
  response.render "index/new"
