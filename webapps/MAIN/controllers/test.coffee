debug = require.main.exports.get("debug")(__filename)

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

exports.addMessage = (request, response) ->
    debug "Add a message to the session"
    request.session.messages.push {
        type : "success"
        title : "Successfully did something!"
        text : "Wooohooo. <br/>You did SOMETHING! Everyone likes that!"
    }
    response.render "test/message"
