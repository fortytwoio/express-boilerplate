cluster = require "cluster"
os = require "os"
cpuCount = os.cpus().length

i = 0

while i < cpuCount
    cluster.fork()
    i = i + 1

cluster.on "listening", (worker, address)->
    console.log "Worker ##{worker.id} is now connected to #{address.address}:#{address.port} (addressType: #{address.addressType})"


cluster.on "disconnect", (worker)->
    console.log "The worker ##{worker.id} has disconnected"


cluster.on "exit", (worker) ->
    console.log "The worker ##{worker.id} died :("
    cluster.fork()


