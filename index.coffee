express = require "express"
debugModule = require "debug"
_ = require "lodash"
config = require "./config/config.json"

app = module.exports = express()
app.settings = _.assign app.settings, config.settings or {}
app.locals = _.assign app.locals, config.locals or {}
port = process.env.APP_PORT or app.settings.port or 3000
hostname = process.env.APP_HOSTNAME or app.settings.hostname or '127.0.0.1'

projectName = app.get 'project_name'
debug = debugModule "#{projectName}"

# Application Mounting:
app.use "/", require "./app"

## As you can see, your app(s) can also be each seperate node modules (even public npm modules if you want so)
#app.use "/fancydashboard/", require "fancy-dashboard"

## You can also use a different url prefix if you want. Make sure you use 'baseurl' in your views:
#app.use "/mynewapp/", require "./app"

## Just add more apps and mount them:
#app.use "/app-2/", require "./app-2"
#app.use "/app-3/", require "./app-3"

app.listen port, hostname, ->
  debug "Listening on http://#{hostname}:#{port}"
