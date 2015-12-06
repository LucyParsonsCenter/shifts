Formsy = require('formsy-react')
FormsyComponent = require('formsy-react-components')
Select = FormsyComponent.Select
Input = FormsyComponent.Input
React = require('react')

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

  render: ->
    <Formsy.Form
      className="event-form"
      onSubmit={this.props.onSubmit}
      onValid={this.props.onValid}
      onInvalid={this.props.onInvalid}>
      <FormSection stepTitle="Event">
      <Input
        name="date"
        type="date"
        onChange={this.props.onchange}
        value={this.props.formData["date"] || ""}
        label="Date: "
        required />
    </Formsy.Form>

module.exports = EventForm
