BigCalendar = require('react-big-calendar')

Calendar = React.createClass
  propTypes: ->
    events:     React.PropTypes.object

  render: ->
    <div id="calendar">
      <BigCalendar />
    </div>

module.exports = Calendar
