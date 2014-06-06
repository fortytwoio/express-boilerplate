express = require "express"
debugModule = require "debug"
_ = require "lodash"
loadWebApps = require "./load-web-apps"
path = require "path"
configFilePath = path.resolve __dirname, "..", "config"
config = require configFilePath
assert = require "assert"
util = require "util"
async = require "async"
setupAppRouting = require "./setup-app-routing"
fileloader = require "loadfiles"

assert config.settings, "Configuration should contain a 'settings' hash"

module.exports = app = express()
app.settings = _.assign app.settings, config.settings or {}
app.locals = _.assign app.locals, config.locals or {}

port = process.env.APP_PORT or app.settings.port or 3000
hostname = process.env.APP_HOSTNAME or app.settings.hostname or '127.0.0.1'

applicationName = app.get "application_name"
assert applicationName, "'application_name' is missing in '#{configFilePath}'."

debug = debugModule "#{applicationName}"

webappsPath = app.get "webapps_path"
assert webappsPath, "'webapps_path' is missing in '#{configFilePath}'."
webappsPath = path.resolve webappsPath


loadWebApps webappsPath, (error, webapps) ->
  debug "Loaded %s webapp(s)", webapps.length

  # Mounting all found webapps
  # webapp: { mountpoint: '/', app: [express app], name: "ROOT", path: "/path/to/webapps/ROOT" }
  webapps.forEach (webapp) ->
    debug "Mounting '#{webapp.name}' at '#{webapp.mountpoint}'"
    ## Initialize the
    loader = fileloader webapp.path, "coffee"

    ## TODO: Refactor this ugly piece of code. Please.
    ## directory structure should be configurable in package.json according to commonjs
    routers = loader "routers"
    controllers = loader "controllers"
    setupAppRouting webapp.app, controllers, routers
    app.use webapp.mountpoint, webapp.app

  app.listen port, hostname, ->
    debug "Listening on http://#{hostname}:#{port}"
