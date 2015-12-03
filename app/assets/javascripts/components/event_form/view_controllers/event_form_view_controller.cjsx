alt = require("../../shared/alt")
EventFormActions = require("../actions/event_form_actions")

class EventFormstore
  constructor: ->
    this.formData = {}

    this.bindListeners
      handleSetCanSubmit:   EventFormActions.SET_CAN_SUBMIT
      handleFormChanged:    EventFormActions.FORM_CHANGED
