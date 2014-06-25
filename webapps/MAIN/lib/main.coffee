path = require "path"
express = require "express"
cookieParser = require "cookie-parser"
session = require "cookie-session"
bodyParser = require "body-parser"
morgan = require "morgan"
errorHandler = require "errorhandler"
util = require "util"
pathToRegexp = require "path-to-regexp"
crypto = require "crypto"
_ = require "lodash"
root = require.main.exports

getMd5 = (string) ->
    string = string || ""
    string = string.trim().toLowerCase()
    md5Sum = crypto.createHash "md5"
    md5Sum.update string
    return md5Sum.digest "hex"

debug = root.get("debug")(__filename)
app = exports = module.exports = express()

parentSettings = if root.settings then root.settings else {}
app.settings = _.assign app.settings, parentSettings
parentLocals = if root.locals then root.locals else {}
app.locals = _.assign app.locals, parentLocals


viewTemplateBaseDir = path.join __dirname, "..", "views", "templates"
viewBaseDir = path.join __dirname, "..", "views"
app.set "views", viewTemplateBaseDir
app.set "view engine", "jade"
app.set "trust proxy", true
app.locals.basedir = viewBaseDir # This will allow us to use absolute paths in jade when using the 'extends' directive

if "development" is app.get "env"
    debug "Setting development settings"
    app.locals.pretty = true # This will pretty print html output in development mode
    app.set "view cache", false
    app.use morgan("dev")
else
    debug "Setting production settings"
    app.locals.pretty = false
    app.set "view cache", true
    app.use morgan()

# parse application/x-www-form-urlencoded
app.use bodyParser.urlencoded { extended : true }

# parse application/json
app.use bodyParser.json()

# parse application/vnd.api+json as json. http://jsonapi.org
app.use bodyParser.json({ type : 'application/vnd.api+json' })

app.use cookieParser()

sessionSettings = app.get "session"
app.use session {
    keys : [ sessionSettings.secret ]
    proxy : true
}


# Make sure session.messages always exists and is an array
app.use (request, response, next) ->
    request.session.messages = request.session.messages or []
    response.locals.messages = request.session.messages.splice(0)
    next()


# set baseurl based on mountpath
app.use (request, response, next) ->
    response.locals.baseurl = request.baseUrl
    response.locals.request = request
    response.locals.isActive = (urlPath) ->
        if !urlPath then return false
        keys = []
        paths = []
        if request.baseUrl
            paths.push request.baseUrl
        if request.route.path != '/'
            paths.push request.route.path
        routePath = paths.join ""
        regex = pathToRegexp routePath, keys, { sensitive : false, strict : false }
        matches = urlPath.match regex
        debug "match?", (null != matches), regex, keys, urlPath, routePath
        return (null != matches)
    response.locals.md5 = getMd5
    response.locals.gravatar = (email) ->
        return "https://secure.gravatar.com/avatar/#{getMd5(email)}?"
    next()


if "development" is app.get "env"
    debug "Adding errorHandler"
    app.use errorHandler()

