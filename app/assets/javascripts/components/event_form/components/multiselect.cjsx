React = require('react')
Select = require('react-select')

Multiselect = React.createClass
  propTypes: ->
    name:         React.PropTypes.string
    options:      React.PropTypes.array
    placeholder:  React.PropTypes.string
    id:           React.PropTypes.string
    onChange:     React.PropTypes.func
    value:        React.PropTypes.string
    label:        React.PropTypes.string

  getDefaultProps: ->
    multi: false
    label: ""
    placeholder: ""

  render: ->
    <div>
      <Select
        name={this.props.name}
        options={this.props.options}
        placeholder={this.props.placeholder}
        multi=true
        id={this.props.id}
        onChange={this.props.onChange}
        value={this.props.value}
        label={this.props.label} />
    </div>

module.exports = Multiselect
