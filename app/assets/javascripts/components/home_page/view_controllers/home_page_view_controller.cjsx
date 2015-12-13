alt = require("../../shared/alt.js.coffee")
request = require("superagent")
require('superagent-csrf')(request)
HomePageActions = require("../actions/home_page_actions.cjsx")
EventForm = require("../components/event_form.cjsx")
HomePageStore = require("../stores/home_page_store.cjsx")
Calendar = require("../components/calendar.cjsx")

HomePageVC = React.createClass
  propTypes: ->
    collectiveMembers:  React.PropTypes.object
    trainees:           React.PropTypes.object

  onChange: ->
    this.forceUpdate()

  componentWillMount: ->
    HomePageActions.setTrainees(this.props.trainees)
    HomePageActions.setCollectiveMembers(this.props.collectiveMembers)
    HomePageStore.listen(this.onChange)

  componentWillUnmount: ->
    HomePageStore.unlisten(this.onChange)

  render: ->
    <Calendar
      events={[{
        "title": "Some Event",
        "start": new Date(2015, 3, 9, 0, 0, 0),
        "end": new Date(2015, 3, 9, 0, 0, 0)
      }]}
    />

  renderForm: ->
    <div id="event-form">
      <EventForm
        onSubmit={this.onSubmit}
        collectiveMembers={this.props.collectiveMembers}
        trainees={this.props.trainees}
        serverErrors={HomePageStore.getServerErrors()} />
    </div>

  onSubmit: (data) ->
    $.ajax(
      url: "/create_or_update_event"
      type: "POST"
      data: data
      success: (data, textStatus, jqXHR) ->
        console.log(data)
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(errorThrown)
    )

module.exports = HomePageVC
