alt = require("../../shared/alt.js.coffee")

class EventFormActions
  constructor: ->
    this.generateActions(
      'dateHack',
      'setCanSubmit',
      'formChanged',
      'setFormState',
      'clearFormData',
      'setID'
      'formatMultiselect'
    )

module.exports = alt.createActions(EventFormActions)
