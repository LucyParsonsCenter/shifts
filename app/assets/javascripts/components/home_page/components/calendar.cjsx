BigCalendar = require('react-big-calendar')
moment = require('moment')

Calendar = React.createClass
  propTypes: ->
    events:     React.PropTypes.object

  componentWillMount: ->
    BigCalendar.momentLocalizer(moment)

  render: ->
    <div id="calendar">
      <BigCalendar />
    </div>

module.exports = Calendar
