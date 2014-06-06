open = require "gulp-open"

module.exports = () ->
  gulp
  .src "index.html"
  .pipe open("",
    url: "http://localhost:3000"
  )
