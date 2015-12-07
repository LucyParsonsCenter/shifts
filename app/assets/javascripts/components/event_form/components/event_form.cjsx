Formsy = require('formsy-react')
FormsyComponent = require('formsy-react-components')
Select = FormsyComponent.Select
Input = FormsyComponent.Input
Radio = FormsyComponent.RadioGroup

EventForm = React.createClass
  propTypes: ->
    canSubmit:          React.PropTypes.bool.isRequired
    onSubmit:           React.PropTypes.func.isRequired
    onFormChanged:      React.PropTypes.func.isRequired
    onValid:            React.PropTypes.func.isRequired
    onInvalid:          React.PropTypes.func.isRequired
    formData:           React.PropTypes.object.isRequired
    serverErrors:       React.PropTypes.array
    collectiveMembers:  React.PropTypes.object.isRequired
    trainees:           React.PropTypes.object.isRequired

  getDefaultProps: ->
    serverErrors: []
    formData: {}

  render: ->
    <Formsy.Form
      className="event-form"
      onSubmit={this.props.onSubmit}
      onValid={this.props.onValid}
      onInvalid={this.props.onInvalid}>
      <Radio
        name="eventType"
        type="inline"
        label="Event Type"
        value={this.props.formData["eventType"] || '1'}
        options={[
            {value: '1', label: "Shift"},
            {value: '2', label: "Training shift"},
            {value: '3', label: "Meeting"},
            {value: '4', label: "Event!"}
        ]}
        onChange={this.props.onChange} />
      <Input
        name="date"
        type="date"
        value={this.props.formData["date"] || ""}
        onChange={this.props.onChange}
        label="Date: "
        required />
      <Input
        name="startTime"
        type="time"
        value={this.props.formData["startTime"] || ""}
        onChange={this.props.onChange}
        label="Start time: "
        required />
      <Input
        name="time"
        type="time"
        value={this.props.formData["endTime"] || ""}
        onChange={this.props.onChange}
        label="End time: "
        required />
      {this.renderConditionalInputs()}
    </Formsy.Form>

  renderConditionalInputs: ->
    eventType = this.props.formData["eventType"]
    if eventType == '1'
      this.renderCollectiveMember()
    else if eventType == '2'
      this.renderCollectiveMember()
      this.renderTrainee
    else if eventType == '4'
      this.renderCollectiveMember()

  renderTrainee: ->
    <Select
      name="trainee"
      onChange={this.props.onChange}
      value={this.props.formData["trainee"] || []}
      label="Trainee: "
      multiple
      placeholder="Pick a trainee!"
      options={this.props.collectiveMembers}
      required
    />

  renderCollectiveMember: ->
    <Select
      name="collectiveMember"
      onChange={this.props.onChange}
      value={this.props.formData["collectiveMembers"] || []}
      label="Collective Member"
      multiple
      placeholder="Pick a collective member (or two!)"
      options={this.props.collectiveMembers}
      required
    />

module.exports = EventForm
