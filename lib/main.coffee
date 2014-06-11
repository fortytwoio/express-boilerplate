express = require "express"
_ = require "lodash"
path = require "path"
assert = require "assert"
util = require "util"
fileloader = require "loadfiles"
loadWebApps = require "./loadwebapps"
setupAppRouting = require "./setupapprouting"

module.exports = app = express()

configFilePath = path.resolve __dirname, "..", "config"
config = require configFilePath
assert config.settings, "Configuration should contain a 'settings' hash"

app.settings = _.assign app.settings, config.settings or {}
app.locals = _.assign app.locals, config.locals or {}
applicationName = app.settings['application_name'] or "#{path.basename(path.resolve(__dirname, ".."))}"
assert applicationName, "'application_name' is missing in '#{configFilePath}'."

port = process.env.APP_PORT or app.settings.port or 3000
hostname = process.env.APP_HOSTNAME or app.settings.hostname or '127.0.0.1'

webappsPath = app.settings['webapps_path'] or "webapps"
assert webappsPath, "'webapps_path' is missing in '#{configFilePath}'."
webappsPath = path.resolve webappsPath

getDebug = require("./getDebug")(applicationName, path.resolve __dirname, "..")
app.set "debug", getDebug
debug = getDebug __filename

# Use static middleware in dev, and use e.g. nginx in production for static asset serving
app.use express.static path.resolve ( "./public")

rootPath = path.resolve __dirname, ".."

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

        routers = loader "routers"
        controllers = loader "controllers"
        setupAppRouting webapp.app, controllers, routers
        app.use webapp.mountpoint, webapp.app

    app.listen port, hostname, ->
        debug "Listening on http://#{hostname}:#{port}"
