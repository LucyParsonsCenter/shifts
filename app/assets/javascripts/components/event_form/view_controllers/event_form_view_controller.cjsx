alt = require("../../shared/alt.js.coffee")
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
        onSubmit={this.props.onSubmit}
        onFormChanged={this.props.onFormChanged}
        onValid={this.props.onValid}
        onInvalid={this.props.onInvalid}
        collectiveMembers={this.props.collectiveMembers}
        trainees={this.props.trainees}
        formData={EventFormStore.getFormData()}
        serverErrors={EventFormStore.getServerErrors()} />
    </div>

  onFormChanged: (key, value) ->
    EventFormActions.formChanged({key: key, value: value})

  onValid: ->
    EventFormActions.setCanSubmit(true)

  onInvalid: ->
    EventFormActions.setCanSubmit(false)

  onSubmit: (data) ->
    console.log(data)

module.exports = EventFormVC
