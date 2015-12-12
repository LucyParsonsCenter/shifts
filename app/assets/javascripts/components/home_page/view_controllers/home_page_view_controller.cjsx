alt = require("../../shared/alt.js.coffee")
request = require("superagent")
require('superagent-csrf')(request)
HomePageActions = require("../actions/event_form_actions.cjsx")
EventForm = require("../components/event_form.cjsx")
HomePageStore = require("../stores/event_form_store.cjsx")
Calendar = require("../components/calendar.cjsx")

HomePageVC = React.createClass
  propTypes: ->
    collectiveMembers:  React.PropTypes.object
    trainees:           React.PropTypes.object

  onChange: ->
    this.forceUpdate()

  componentWillMount: ->
    HomePageStore.listen(this.onChange)

  componentWillUnmount: ->
    HomePageStore.unlisten(this.onChange)

  render: ->
    <Calendar />

  renderForm: ->
    <div id="event-form">
      <EventForm
        canSubmit={EventFormStore.getCanSubmit()}
        onSubmit={this.onSubmit}
        onFormChanged={this.onFormChanged}
        onValid={this.onValid}
        onInvalid={this.onInvalid}
        collectiveMembers={this.props.collectiveMembers}
        trainees={this.props.trainees}
        formData={EventFormStore.getFormData()}
        serverErrors={EventFormStore.getServerErrors()} />
    </div>

  onFormChanged: (key, value) ->
    HomePageActions.formChanged({key: key, value: value})

  onValid: ->
    HomePageActions.setCanSubmit(true)

  onInvalid: ->
    HomePageActions.setCanSubmit(false)

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
