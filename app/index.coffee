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
fileloader = require "loadfiles"
load = fileloader __dirname, "coffee"
defaultRoutingSetup = require "../lib/defaultRoutingSetup"

app = module.exports = express()
parentSettings = if module.parent?.exports?.settings then module.parent.exports.settings else {}
app.settings = _.assign app.settings, parentSettings
parentLocals = if module.parent?.exports?.locals then module.parent.exports.locals else {}
app.locals = _.assign app.locals, parentLocals

projectName = app.get 'project_name'
debug = debugModule "#{projectName}:app"

viewBaseDir = path.join __dirname, "views"
app.set "views", viewBaseDir
app.set "view engine", "jade"
app.set "trust proxy", true
app.locals.basedir = viewBaseDir # This will allow us to use absolute paths in jade when using the 'extends' directive

if "development" is app.get "env"
  app.locals.pretty = true # This will pretty print html output in development mode
  app.set "view cache", false
  app.use express.static(path.join(__dirname, 'public'))
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
  response.locals.baseurl = request.app.path().replace /[\/]*$/, ""
  next()

if "development" is app.get "env"
  app.use errorHandler()

routers = load "routers"
controllers = load "controllers"
middlewares = load "middlewares"


###
  TODO: setupRouter should be in its own file or even a seperate node module
###
setupRouter = (app, routeName, actions, routers, middlewares) ->
  debug "Setting up '#{routeName}' routes"
  if routers.hasOwnProperty(routeName)
    routingSetup = routers[routeName]
  else
    debug "Using default routing setup for '#{routeName}'"
    routingSetup = defaultRoutingSetup
  if routeName == "index"
    route = "/"
  else
    route = "/#{routeName}"
  app.use route, routingSetup(actions, middlewares)

# Make sure the "index" route gets added first
if controllers.index
  setupRouter app, "index", controllers['index'], routers, middlewares
  delete controllers.index # delete index router so we do not add it twice

for name, controller of controllers
  setupRouter app, name, controllers[name], routers, middlewares

