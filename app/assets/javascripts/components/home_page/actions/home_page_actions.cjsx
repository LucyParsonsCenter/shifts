alt = require("../../shared/alt.js.coffee")

class HomePageActions
  constructor: ->
    this.generateActions(
      'setCanSubmit',
      'formChanged',
      'setFormState'
    )

module.exports = alt.createActions(HomePageActions)
