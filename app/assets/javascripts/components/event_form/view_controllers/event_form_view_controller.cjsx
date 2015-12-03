alt = require("../../shared/alt")
EventFormActions = require("../actions/event_form_actions")
EventForm = require("../components/event_form")
EventFormStore = require("../stores/event_form_store")

class EventFormstore
  constructor: ->
    this.formData = {}

    this.bindListeners
      handleSetCanSubmit:   EventFormActions.SET_CAN_SUBMIT
      handleFormChanged:    EventFormActions.FORM_CHANGED
      handleSetFormState:   EventFormActions.SET_FORM_STATE
