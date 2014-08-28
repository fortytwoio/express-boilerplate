clusterMaster = require "cluster-master"
os = require "os"

cpuCount = parseInt process.env.APP_WORKERS or os.cpus().length or 1

module.exports = clusterMaster {
    exec : "#{__dirname}/root.coffee"
    size : cpuCount ## This is the default anyways
}
