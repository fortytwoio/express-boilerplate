express = require "express"

module.exports = setupTestRouter = (actions) ->
    router = express.Router()
    router.get "/", actions.index
    router.get "/foo", actions.getFoo
    router.get "/message", actions.addMessage
    return router

