alt = require("../../shared/alt.js.coffee")

class EventFormActions
  constructor: ->
    this.generateActions(
      'setCanSubmit',
      'formChanged',
      'setFormState',
      'idChanged',
      'clearFormData'
    )

module.exports = alt.createActions(EventFormActions)
