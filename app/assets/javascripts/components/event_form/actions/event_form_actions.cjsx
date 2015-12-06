alt = require("../../shared/alt")

class EventFormActions
  constructor: ->
    this.generateActions(
      'setCanSubmit',
      'formChanged',
      'setFormState'
    )

module.exports = alt.createActions(EventFormActions)
