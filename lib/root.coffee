express = require "express"
_ = require "lodash"
path = require "path"
assert = require "assert"
loadApps = require "express-load-apps"
getDebug = require "getdebug"

# This is important! You can access this in all other modules
# via require.main.exports
app = exports = module.exports = express()

configFilePath = path.resolve __dirname, "..", "config"
config = require configFilePath
assert config.settings, "Configuration should contain a 'settings' hash"

app.settings = _.assign app.settings, config.settings or {}
app.locals = _.assign app.locals, config.locals or {}

port = process.env.APP_PORT or app.settings.port or 3000
hostname = process.env.APP_HOSTNAME or app.settings.hostname or '127.0.0.1'

webappsPath = app.settings['webapps_path'] or "webapps"
assert webappsPath, "'webapps_path' is missing in '#{configFilePath}'."
webappsPath = path.resolve webappsPath

app.set "debug", getDebug
debug = getDebug __filename

# Use static middleware in dev, and use e.g. nginx in production for static asset serving
if "development" is app.get "env"
    app.use express.static path.resolve("./public")

loadApps webappsPath, (error, webapps) ->
    debug "Loaded %s webapp(s)", webapps.length
    # Mounting all found webapps
    # webapp: { mountpoint: '/', app: [express app], name: "ROOT", path: "/path/to/webapps/ROOT", controllers: [], routers: [] }
    webapps.forEach (webapp) ->
        debug "Mounting '#{webapp.name}' at '#{webapp.mountpoint}'"
        app.use webapp.mountpoint, webapp.app


app.listen port, hostname, ->
    debug "Listening on http://#{hostname}:#{port}"
