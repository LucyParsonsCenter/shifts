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
      <Input
        name="date"
        type="date"
        value={this.props.formData["date"] || ""}
        onChange={this.props.onChange}
        label="Date: "
        required />
      <Radio
        name="eventType"
        type="inline"
        label="Event Type"
        value={this.props.formData["eventType"]}
        options={[
            {value: '1', label: "Shift"},
            {value: '2', label: "Training shift"},
            {value: '3', label: "Meeting"},
            {value: '4', label: "Event!"}
        ]}
        onChange={this.props.onChange} />
    </Formsy.Form>

module.exports = EventForm
