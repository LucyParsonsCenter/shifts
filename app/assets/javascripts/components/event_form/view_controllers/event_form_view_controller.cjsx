alt = require("../../shared/alt")
EventFormActions = require("../actions/event_form_actions")
EventForm = require("../components/event_form")
EventFormStore = require("../stores/event_form_store")

EventFormVC = React.createClass
  propTypes: ->
    initialFormData:    React.PropTypes.object
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
        onSubmit={this.onSubmit}
        onFormChanged={this.onFormChanged}
        onValid={this.onValid}
        onInvalid={this.onInvalid}
        formData={EventFormStore.getFormData()}
        serverErrors={EventFormStore.getServerErrors()} />
    </div>

  onFormChanged: ->

module.exports = EventFormVC
