debugModule = require "debug"
path = require "path"

module.exports = getDebug = (applicationName, applicationRootPath)->
    return (filename)->
        relativePath = path.relative applicationRootPath, filename
        extname = path.extname relativePath
        filename = path.basename relativePath, extname

        debugParts = path.dirname("#{relativePath}").split("/")
        debugParts.push filename
        relativeIdentifier = debugParts.join ":"
        return debugModule "#{applicationName}:#{process.pid}:#{relativeIdentifier.toLowerCase()}"
