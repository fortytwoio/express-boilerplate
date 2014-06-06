express = require "express"

app = require ".."
debug = app.getDebug __filename

module.exports = setupTestRouter = (actions) ->
  debug "Doing router setup"
  router = express.Router()
  router.get "/", actions.index
  router.get "/foo", actions.getFoo
  router.get "/message", actions.addMessage
  return router

