express = require 'express'
_ = require 'lodash'
path = require 'path'
assert = require 'assert'
getDebug = require 'getdebug'
errorhandler = require 'errorhandler'

debug = getDebug __filename

root = exports = module.exports = express()

configFilePath = path.resolve __dirname, '..', 'config'
config = require configFilePath
assert config.settings, "Configuration should contain a 'settings' hash"

root.settings = _.assign root.settings, config.settings or {}
root.locals = _.assign root.locals, config.locals or {}

port = process.env.APP_PORT or root.settings.port or 3000
hostname = process.env.APP_HOSTNAME or root.settings.hostname or '127.0.0.1'

# Use static middleware in dev, and use e.g. nginx in production for static asset serving
#if 'development' is root.get 'env' then root.use express.static path.resolve('./public')
root.use express.static path.resolve('./public')

app = require '../app'
root.use '/', app

if 'development' is root.get 'env'
    root.use errorhandler 'dev'
else
    root.use errorhandler 'combined'

root.listen port, hostname, ->
    debug "Listening on http://#{hostname}:#{port}"


