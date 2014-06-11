# @cjsx React.DOM

React = require "react"
Timer = require "./timer"

module.exports = AnotherTestWidget = React.createClass
    render: ->
        <div>
            <p>This is AnotherTestWidget</p>
            <Timer />
        </div>


