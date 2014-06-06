###
GET     /                 ->  exports.index
GET     /new              ->  exports.new
POST    /                 ->  exports.create
GET     /:id              ->  exports.show
GET     /:id/edit         ->  exports.edit
PUT     /:id              ->  exports.update
DELETE  /:id              ->  exports.destroy
###


## BEFORE:
#app = require "../"
#applicatioName = app.get 'application_name'
#debug = require("debug")("#{applicatioName}:app:controllers:index")

## VARIANT 1:
app = require "../"
debug = app.getDebug __filename
debug "Test Debug Message"


## VARIANT 2:
debug = ROOT.getDebug __filename
debug "Another Test Debug Message"

exports.index = (request, response) ->
  debug "Requested index"
  response.render "index"

exports.new = (request, response) ->
  debug "Requested index/new"
  response.render "index/new"
