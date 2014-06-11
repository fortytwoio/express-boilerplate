# @cjsx React.DOM

React = require "react"
AnotherTestWidget = require "./anothertestwidget"

module.exports = TestComponent = React.createClass
    render: ->
        <div>
            <h1>Hello from my React Test Widget!</h1>
            <AnotherTestWidget />
        </div>
