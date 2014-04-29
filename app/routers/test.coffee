express = require "express"

###
  TODO: Rethink if 'middlewares' array should be passed to the setup function, or if a router should require its required middlewares itself
###
module.exports = setupTestRouter = (actions, middlewares) ->
  router = express.Router()
  router.get "/", actions.index
  router.get "/foo", actions.getFoo
  router.get "/message", actions.addMessage
  return router

