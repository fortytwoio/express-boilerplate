cluster = require "cluster"

if cluster.isMaster
    require "./master"
else
    # We set the root app as a global, accessible everywhere as 'ROOT'
    module.exports = global.ROOT = require "./worker"
