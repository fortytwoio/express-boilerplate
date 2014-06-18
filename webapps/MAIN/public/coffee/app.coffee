foo = require "./foo"
bar = require "./bar"
TestComponent = require "./cjsx/testcomponent.cjsx"
React = require "react"

test = ->
    bar()
    foo()
    React.renderComponent TestComponent(), document.getElementById("reactive")

test()
