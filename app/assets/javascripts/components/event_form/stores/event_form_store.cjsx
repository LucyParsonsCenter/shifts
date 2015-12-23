alt = require("../../shared/alt.js.coffee")
EventFormActions = require("../actions/event_form_actions.cjsx")

class EventFormStore
  constructor: ->
    this.formData = {}
    this.canSubmit = false
    this.serverErrors = []

    this.bindListeners
      handleSetCanSubmit:   EventFormActions.SET_CAN_SUBMIT
      handleFormChanged:    EventFormActions.FORM_CHANGED
      handleSetID:          EventFormActions.SET_ID
      handleSetFormState:   EventFormActions.SET_FORM_STATE
      handleClearFormData:  EventFormActions.CLEAR_FORM_DATA
      handleDateHack:       EventFormActions.DATE_HACK

    this.exportPublicMethods
      getCanSubmit:     this.getCanSubmit
      getFormData:      this.getFormData
      getServerErrors:  this.getServerErrors

  handleDateHack: (date) ->
    switch date[0]
      when "dateHack"
        this.formData["date"] = date[1]
      when "startHack"
        this.formData["startTime"] = date[1]
      when "endHack"
        this.formData["endTime"] = date[1]

  handleSetCanSubmit: (state) ->
    this.canSubmit = state

  handleClearFormData: ->
    this.formData = {}

  handleFormChanged: (newData) ->
    this.formData[newData.key] = newData.value

  handleSetID: (id) ->
    this.formData["eventID"] = id

  handleSetFormState: (hack) ->
    this.formData = hack.data
    this.formData["eventID"] = hack.id

  # public methods

  getCanSubmit: ->
    this.getState().canSubmit

  getFormData: ->
    this.getState().formData

  getServerErrors: ->
    this.getState().serverErrors

module.exports = alt.createStore(EventFormStore, "EventFormStore")
