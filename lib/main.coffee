express = require "express"
debugModule = require "debug"
_ = require "lodash"
loadWebApps = require "./load-web-apps"
path = require "path"
configFilePath = path.resolve __dirname, "..", "config"
config = require configFilePath
assert = require "assert"
util = require "util"
setupAppRouting = require "./setup-app-routing"
fileloader = require "loadfiles"

assert config.settings, "Configuration should contain a 'settings' hash"

module.exports = app = express()
app.settings = _.assign app.settings, config.settings or {}
app.locals = _.assign app.locals, config.locals or {}

port = process.env.APP_PORT or app.settings.port or 3000
hostname = process.env.APP_HOSTNAME or app.settings.hostname or '127.0.0.1'

applicationName = app.settings['application_name'] or "#{path.basename(path.resolve(__dirname, ".."))}"
assert applicationName, "'application_name' is missing in '#{configFilePath}'."

debug = debugModule "#{applicationName}"

webappsPath = app.settings['webapps_path'] or "webapps"
assert webappsPath, "'webapps_path' is missing in '#{configFilePath}'."
webappsPath = path.resolve webappsPath

rootPath = path.resolve __dirname, ".."

# For Variant 2:
app.getDebug = (filename)->
  relativePath = path.relative webappsPath, filename
  extname = path.extname relativePath
  basename = path.basename relativePath, extname

  relativeIdentifier = path.dirname relativePath
  .split "/"
  .join ":"
  return debugModule "#{applicationName.toLowerCase()}:#{relativeIdentifier.toLowerCase()}:#{basename.toLowerCase()}"


loadWebApps webappsPath, (error, webapps) ->
  debug "Loaded %s webapp(s)", webapps.length

  # Mounting all found webapps
  # webapp: { mountpoint: '/', app: [express app], name: "ROOT", path: "/path/to/webapps/ROOT" }
  webapps.forEach (webapp) ->
    debug "Mounting '#{webapp.name}' at '#{webapp.mountpoint}'"

    # Initialize the file loader with the path to the webapp
    loader = fileloader webapp.path, "coffee"

    # The directory structure should be configurable in package.json according to commonjs.
    # Also if this app should be bootstrapped or not. Opt-In

    # For Variant 1:
    webapp.app.getDebug = (filename)->
      relativePath = path.relative webapp.path, filename
      extname = path.extname relativePath
      basename = path.basename relativePath, extname

      relativeIdentifier = path.dirname relativePath
      .split "/"
      .join ":"
      return debugModule "#{applicationName}:#{webapp.name.toLowerCase()}:#{relativeIdentifier}:#{basename}"

    routers = loader "routers"
    controllers = loader "controllers"
    setupAppRouting webapp.app, controllers, routers
    app.use webapp.mountpoint, webapp.app

  app.listen port, hostname, ->
    debug "Listening on http://#{hostname}:#{port}"
