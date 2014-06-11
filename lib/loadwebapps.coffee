debugModule = require "debug"
debug = debugModule "loadwebapps"
express = require "express"
assert = require "assert"

fs = require "fs"
path = require "path"
async = require "async"

module.exports = loadWebApps = (webappsPath, callback)->
    debug "Searching for webapps in '%s'", webappsPath
    webapps = []
    mountApp = (webappName, callback) ->
        webappPath = path.resolve webappsPath, webappName

        debug "Requiring '#{webappName}' at '#{webappPath}'"
        webapp = require webappPath

        # Lazy check if exported module seems to look like an express app. instanceof did not work. :(
        assert webapp.settings && webapp.locals && webapp.use && webapp.request && webapp.response && webapp.mountpath && webapp.get && webapp.set, "WebApp '#{webappName}' at '#{webappPath}' seems not to be (or export) an express app"

        mountpoint = "/#{webappName}/"
        if webappName == "MAIN" then mountpoint = "/"
        webapps.push
            mountpoint : mountpoint
            app :        webapp
            name :       webappName
            path :       webappPath

        callback(null)

    fs.readdir webappsPath, (error, contents) ->
        if error then return callback new Error("Error reading '#{webappsPath}': '#{util.inspect(error, depth : null)}'"), null
        webappNames = contents.filter (content) ->
            stats = fs.statSync path.resolve(webappsPath, content)
            return stats.isDirectory()
        async.each webappNames, mountApp, (error)->
            process.nextTick ->
                return callback(error, webapps)
