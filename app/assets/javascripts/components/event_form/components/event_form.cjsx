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
        onChange={this.props.onFormChanged}
        options={[
            {value: '1', label: "Shift"},
            {value: '2', label: "Training shift"},
            {value: '3', label: "Meeting"},
            {value: '4', label: "Event!"}
        ]}
        onChanged={this.props.onFormChanged} />
      <Input
        name="date"
        type="date"
        value={this.props.formData["date"] || ""}
        onChange={this.props.onFormChanged}
        label="Date: "
        required />
      <Input
        name="startTime"
        type="time"
        value={this.props.formData["startTime"] || ""}
        onChange={this.props.onFormChanged}
        label="Start time: "
        required />
      <Input
        name="time"
        type="time"
        value={this.props.formData["endTime"] || ""}
        onChange={this.props.onFormChanged}
        label="End time: "
        required />
      {this.renderConditionalInputs()}
    </Formsy.Form>

  renderConditionalInputs: ->
    eventType = this.props.formData["eventType"]
    if eventType == '1' or eventType == undefined
      this.renderCollectiveMember()
    else if eventType == '2'
      <div>
        {this.renderCollectiveMember()}
        {this.renderTrainee()}
      </div>
    else if eventType == '4'
      <div>
        {this.renderCollectiveMember()}
        <Input
          name="eventTitle"
          value={this.props.formData["eventTitle"] || ""}
          onChange={this.props.onFormChanged}
          label="Event title:"
          required />
      </div>

  renderTrainee: ->
    <Select
      name="trainee"
      onChange={this.props.onFormChanged}
      value={this.props.formData["trainee"] || []}
      label="Trainee: "
      multiple
      placeholder="Pick a trainee!"
      options={this.props.collectiveMembers}
      required
    />

  renderCollectiveMember: ->
    <Select
      name="collectiveMembers"
      onChange={this.props.onFormChanged}
      value={this.props.formData["collectiveMembers"] || []}
      label="Collective Member"
      multiple
      placeholder="Pick a collective member (or two!)"
      options={this.props.collectiveMembers}
      required
    />

module.exports = EventForm
