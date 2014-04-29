express = require "express"

###
  TODO: Rethink if 'middlewares' array should be passed to the setup function, or if a router should require its
  middlewares itself
###
module.exports = (actions, middlewares) ->
  router = express.Router()
  router.get "/", actions.index
  router.get "/foo", actions.getFoo
  return router

