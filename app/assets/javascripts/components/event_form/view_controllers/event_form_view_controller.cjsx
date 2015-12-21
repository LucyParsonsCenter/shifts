alt = require("../../shared/alt.js.coffee")
request = require("superagent")
require('superagent-csrf')(request)
EventFormActions = require("../actions/event_form_actions.cjsx")
EventForm = require("../components/event_form.cjsx")
EventFormStore = require("../stores/event_form_store.cjsx")

EventFormVC = React.createClass
  propTypes: ->
    collectiveMembers:  React.PropTypes.object
    trainees:           React.PropTypes.object

  onChange: ->
    this.forceUpdate()

  componentWillMount: ->
    EventFormStore.listen(this.onChange)

  componentWillUnmount: ->
    EventFormStore.unlisten(this.onChange)

  render: ->
    <div id="event-form">
      <EventForm
        canSubmit={EventFormStore.getCanSubmit()}
        onDateHack={EventFormActions.dateHack}
        onSubmit={this.onSubmit}
        onFormChanged={this.onFormChanged}
        onValid={this.onValid}
        onInvalid={this.onInvalid}
        onIdChanged={this.onIdChanged}
        collectiveMembers={this.props.collectiveMembers}
        trainees={this.props.trainees}
        formData={EventFormStore.getFormData()}
        serverErrors={EventFormStore.getServerErrors()} />
    </div>

  onFormChanged: (key, value) ->
    EventFormActions.formChanged({key: key, value: value})

  onIdChanged: (key, value) ->
    EventFormActions.idChanged(value)

  onValid: ->
    EventFormActions.setCanSubmit(true)

  onInvalid: ->
    EventFormActions.setCanSubmit(false)

  onSubmit: (data) ->
    $.ajax(
      url: "/create_or_update_event"
      type: "POST"
      data: data
      success: (data, textStatus, jqXHR) ->
        $('#fullcalendar-modal').modal('hide')
        EventFormActions.clearFormData()
      error: (jqXHR, textStatus, errorThrown) ->
        console.log(errorThrown)
    )

module.exports = EventFormVC
