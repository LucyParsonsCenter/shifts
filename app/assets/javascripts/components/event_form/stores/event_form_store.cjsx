alt = require("../shared/alt")
EventFormActions = require("../actions/event_form_actions")

class EventFormStore
  constructor: ->
    this.formData = {}
    this.canSubmit = false
    this.serverErrors = []

    this.bindListeners
      handleSetCanSubmit:     EventFormActions.SET_CAN_SUBMIT
      
    this.exportPublicMethods
      getCanSubmit:     this.getCanSubmit


  # public methods
  
  getCanSubmit: ->
    this.getState.canSubmit

  getFormData: ->
    this.getState.formData

module.exports = alt.createStore(EventFormStore, "EventFormStore")
