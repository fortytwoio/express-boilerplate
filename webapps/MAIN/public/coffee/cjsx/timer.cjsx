# @cjsx React.DOM
console.log "This is in #{__filename}"
module.exports = Timer = React.createClass
  getInitialState: ->
    return { secondsElapsed: 0 }

  tick: ->
    @setState {secondsElapsed: @state.secondsElapsed + 1}

  componentDidMount: ->
    @interval = setInterval(@tick, 1000);

  componentWillUnmount: ->
    clearInterval(@interval);

  render: ->
      <div>Seconds Elapsed: {@state.secondsElapsed}</div>
