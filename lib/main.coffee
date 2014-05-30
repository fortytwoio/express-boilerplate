express = require "express"
debugModule = require "debug"
_ = require "lodash"
fs = require "fs"
path = require "path"
config = require "./../config/config.json"

app = module.exports = express()
app.settings = _.assign app.settings, config.settings or {}
app.locals = _.assign app.locals, config.locals or {}
port = process.env.APP_PORT or app.settings.port or 3000
hostname = process.env.APP_HOSTNAME or app.settings.hostname or '127.0.0.1'

applicationName = app.get 'application_name'
debug = debugModule "#{applicationName}"

webappsPath = path.resolve __dirname, "..", "webapps"
contents = fs.readdirSync webappsPath
webapps = contents.filter (content) ->
  stats = fs.statSync path.resolve(webappsPath, content)
  return stats.isDirectory()

webapps.forEach (webappName) ->
  webappPath = path.resolve webappsPath, webappName
  debug "Requiring '#{webappName}' at '#{webappPath}'"
  webapp = require webappPath
  mountpoint = "/#{webappName}/"
  if webappName == "ROOT" then mountpoint = "/"
  debug "Mounting app '#{webappName}' at mountpoint '#{mountpoint}'"
  app.use mountpoint, webapp

app.listen port, hostname, ->
  debug "Listening on http://#{hostname}:#{port}"
