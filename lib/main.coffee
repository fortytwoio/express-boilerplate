clusterMaster = require "cluster-master"

os = require "os"
cpuCount = os.cpus().length

clusterMaster
    exec : "#{__dirname}/worker.coffee"
    size : cpuCount ## This is the default anyways
