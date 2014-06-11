foo = require "./foo"
bar = require "./bar"
TestComponent = require "./cjsx/testcomponent.cjsx"
React = require "react"
$ = require "jquery"

test = ->
    bar()
    foo()
    React.renderComponent new TestComponent(), document.getElementById("reactive")

$ ()->
    test()




