alt = require("../../shared/alt.js.coffee")

class HomePageActions
  constructor: ->
    this.generateActions(
      'setTrainees',
      'setCollectiveMembers'
    )

module.exports = alt.createActions(HomePageActions)
