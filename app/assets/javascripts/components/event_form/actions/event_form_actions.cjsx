alt = require("../../shared/alt.js.coffee")

class EventFormActions
  constructor: ->
    this.generateActions(
      'dateHack',
      'setCanSubmit',
      'formChanged',
      'setFormState',
      'idChanged',
      'clearFormData'
    )

module.exports = alt.createActions(EventFormActions)
