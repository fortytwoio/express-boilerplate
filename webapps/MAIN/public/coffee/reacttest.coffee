TestComponent = require "./cjsx/testcomponent.cjsx"
React = require "react"

React.renderComponent TestComponent(), document.getElementById("reactive")
