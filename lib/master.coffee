clusterMaster = require "cluster-master"

os = require "os"
cpuCount = os.cpus().length

module.exports = clusterMaster {
    exec : "#{__dirname}/root.coffee"
    size : cpuCount ## This is the default anyways
}
