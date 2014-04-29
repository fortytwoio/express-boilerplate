###
  GET     /          ->  actions.index
  GET     /new       ->  actions.new
  POST    /          ->  actions.create
  GET     /:Id       ->  actions.show
  GET     /:Id/edit  ->  actions.edit
  PUT     /:Id       ->  actions.update
  DELETE  /:Id       ->  actions.destroy
###

###
  TODO: Rethink how libs in general should be passed to mounted apps
###
express = require "express"
defaultRoutingSetup = module.exports = (actions, middlewares) ->
  router = express.Router()
  if actions.index then router.get "/", actions.index
  if actions.new then router.get "/new", actions.new
  if actions.create then router.post "/", actions.create
  if actions.show then router.get "/:id", actions.show
  if actions.edit then router.get "/:id/edit", actions.edit
  if actions.update then router.put "/:id", actions.update
  if actions.destroy then router.delete "/:id", actions.destroy
  return router
