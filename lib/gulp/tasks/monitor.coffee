nodemon = require "gulp-nodemon"

module.exports = ()->
  nodemon
    script: "./"
    ext: "coffee js jade json"
    ignore: [
      "./var/**",
      "./tmp/**",
      "./webapps/**/public/**/*.*",
    ]
    env:
      "NODE_ENV": "development"
      "DEBUG": "boilerplate:*"
      "DEBUG_COLORS": "y"
  .on "change", ["build"]
