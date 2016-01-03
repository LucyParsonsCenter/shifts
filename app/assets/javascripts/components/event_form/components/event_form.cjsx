Formsy = require('formsy-react')
FormsyComponent = require('formsy-react-components')
Select = FormsyComponent.Select
MultiSelect = require('./multiselect.cjsx')
Input = FormsyComponent.Input
Radio = FormsyComponent.RadioGroup
Button = require('react-bootstrap/lib/Button')
ButtonToolbar = require('react-bootstrap/lib/ButtonToolbar')
ToggleDisplay = require('react-toggle-display')

EventForm = React.createClass
  propTypes: ->
    canSubmit:          React.PropTypes.bool.isRequired
    onDateHack:         React.PropTypes.bool.isRequired
    deleteEvent:        React.PropTypes.func.isRequired
    onIdChanged:        React.PropTypes.func.isRequired
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
    <div id="event-form">
      <Formsy.Form
        className="event-form"
        onSubmit={this.props.onSubmit}
        onValid={this.props.onValid}
        onInvalid={this.props.onInvalid}>
        <ToggleDisplay show=false>
          <Input
            name="eventID"
            id="eventID"
            value={this.props.formData["eventID"] || ""}
            onChange={this.props.onIdChanged} />
          <Input
            name="dateHack"
            id="dateHack"
            value={""}
            onChange={this.props.onDateHack} />
          <Input
            name="startHack"
            id="startHack"
            value={""}
            onChange={this.props.onDateHack} />
          <Input
            name="endHack"
            id="endHack"
            value={""}
            onChange={this.props.onDateHack} />
        </ToggleDisplay>
        <Radio
          name="eventType"
          type="inline"
          id="eventType"
          label="Event Type: "
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
          id="eventDate"
          value={this.props.formData["date"] || ""}
          onChange={this.props.onFormChanged}
          label="Date: "
          required />
        <Input
          name="startTime"
          type="time"
          id="eventStartTime"
          value={this.props.formData["startTime"] || ""}
          onChange={this.props.onFormChanged}
          label="Start time: "
          required />
        <Input
          name="endTime"
          type="time"
          id="eventEndTime"
          value={this.props.formData["endTime"] || ""}
          onChange={this.props.onFormChanged}
          label="End time: "
          required />
        {this.renderConditionalInputs()}
        <input className="btn btn-primary" type="submit" defaultValue="Submit" />
      </Formsy.Form>
      {this.renderEventDelete()}
    </div>

  renderEventDelete: ->
    if this.props.formData["eventID"]
      <ButtonToolbar>
        <Button
          bsStyle="danger"
          onClick={this.deleteHelper.bind(this, this.props.formData["eventID"])}>
          Delete event
        </Button>
      </ButtonToolbar>

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
          id="eventTitle"
          value={this.props.formData["eventTitle"] || ""}
          onChange={this.props.onFormChanged}
          label="Event title:"
          required />
      </div>

  renderTrainee: ->
    <MultiSelect
      name="traineesMulti"
      options={this.props.trainees}
      placeholder="Pick a trainee (or two!)"
      id="trainees"
      onChange={this.selectHelper.bind(this, "traineesMulti")}
      value={this.props.formData["traineesMulti"] || ""}
      label="Trainee"
    />

  renderCollectiveMember: ->
    <MultiSelect
      name="collectiveMembersMulti"
      id="collectiveMembers"
      onChange={this.selectHelper.bind(this, "collectiveMembersMulti")}
      value={this.props.formData["collectiveMembersMulti"] || ""}
      label="Collective Member"
      placeholder="Pick a collective member (or two!)"
      options={this.props.collectiveMembers}
      required
    />

  deleteHelper: (id) ->
    this.props.deleteEvent(id)

  selectHelper: (selectName, changed, selected) ->
    this.props.onFormChanged(selectName, selected)

module.exports = EventForm
