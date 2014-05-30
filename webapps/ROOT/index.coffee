path = require "path"
express = require "express"
favicon = require "static-favicon"
cookieParser = require "cookie-parser"
session = require "cookie-session"
bodyParser = require "body-parser"
debugModule = require "debug"
morgan = require "morgan"
errorHandler = require "errorhandler"
_ = require "lodash"
setupAppRouting = require "setup-app-routing"

fileloader = require "loadfiles"
load = fileloader __dirname, "coffee"

app = module.exports = express()

parentSettings = if module.parent?.exports?.settings then module.parent.exports.settings else {}
app.settings = _.assign app.settings, parentSettings
parentLocals = if module.parent?.exports?.locals then module.parent.exports.locals else {}
app.locals = _.assign app.locals, parentLocals

applicationName = app.get 'application_name'
debug = debugModule "#{applicationName}:app"

viewBaseDir = path.join __dirname, "views"
app.set "views", viewBaseDir
app.set "view engine", "jade"
app.set "trust proxy", true
app.locals.basedir = viewBaseDir # This will allow us to use absolute paths in jade when using the 'extends' directive

if "development" is app.get "env"
  app.locals.pretty = true # This will pretty print html output in development mode
  app.set "view cache", false
  app.use express.static(path.join(__dirname, 'public')) # Use static middleware in dev, and use e.g. nginx in production for static asset serving
  app.use morgan("dev")
else
  app.locals.pretty = false
  app.set "view cache", true
  app.use morgan()

app.use bodyParser()
app.use cookieParser()

sessionSettings = app.get "session"
app.use session
  secret: sessionSettings.secret
  key:    sessionSettings.key
  proxy:  true


# Make sure session.messages always exists and is an array
app.use (request, response, next) ->
  request.session.messages = request.session.messages or []
  response.locals.messages = request.session.messages.splice(0)
  next()


# set baseurl based on mountpath
app.use (request, response, next) ->
  response.locals.baseUrl = request.baseUrl
  next()


if "development" is app.get "env"
  app.use errorHandler()


routers = load "routers"
controllers = load "controllers"

setupAppRouting app, controllers, routers
