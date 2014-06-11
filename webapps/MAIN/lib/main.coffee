path = require "path"
express = require "express"
favicon = require "static-favicon"
cookieParser = require "cookie-parser"
session = require "cookie-session"
bodyParser = require "body-parser"
morgan = require "morgan"
errorHandler = require "errorhandler"
util = require "util"
_ = require "lodash"

debug = ROOT.get("debug")(__filename)
debug "ENV", util.inspect(process.env.NODE_ENV)

app = module.exports = express()

parentSettings = if ROOT.settings then ROOT.settings else {}
app.settings = _.assign app.settings, parentSettings
parentLocals = if ROOT.locals then ROOT.locals else {}
app.locals = _.assign app.locals, parentLocals

viewBaseDir = path.join __dirname, "..", "views"
app.set "views", viewBaseDir
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

app.use bodyParser()
app.use cookieParser()

sessionSettings = app.get "session"
app.use session
            keys :  [ sessionSettings.secret ]
            proxy : true


# Make sure session.messages always exists and is an array
app.use (request, response, next) ->
    request.session.messages = request.session.messages or []
    response.locals.messages = request.session.messages.splice(0)
    next()


# set baseurl based on mountpath
app.use (request, response, next) ->
    response.locals.baseurl = request.baseUrl
    next()


if "development" is app.get "env"
    debug "Adding errorHandler"
    app.use errorHandler()

