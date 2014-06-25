# @cjsx React.DOM

React = require "react"
AnotherTestWidget = require "./anothertestwidget"

module.exports = TestComponent = React.createClass
    displayName: "TestComponent"
    render: ->
        <div>
            <h1>Hello from my React Test Component!</h1>
            <AnotherTestWidget />
        </div>
