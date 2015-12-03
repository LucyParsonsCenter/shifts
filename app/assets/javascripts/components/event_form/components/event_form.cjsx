Formsy = require('formsy-react')
FormsyComponent = require('formsy-react-components')
Select = FormsyComponent.Select
Input = FormsyComponent.Input

EventForm = React.createClass
  propTypes: ->
    canSubmit:        React.PropTypes.bool.isRequired
    onSubmit:         React.PropTypes.func.isRequired
    onFormChanged:    React.PropTypes.func.isRequired
    onValid:          React.PropTypes.func.isRequired
    onInvalid:        React.PropTypes.func.isRequired
    formData:         React.PropTypes.object.isRequired
    serverErrors:     React.PropTypes.array

  getDefaultProps: ->
    serverErrors: []


  render: ->

    <Formsy.Form
      className="event-form"
      onSubmit={this.props.onSubmit}
      onValid={this.props.onValid}
      onInvalid={this.props.onInvalid}>


