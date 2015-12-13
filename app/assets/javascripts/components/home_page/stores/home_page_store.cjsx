alt = require("../../shared/alt.js.coffee")
HomePageActions = require("../actions/home_page_actions.cjsx")

class HomePageStore
  constructor: ->
    this.collectiveMembers = {}
    this.trainees = {}
    this.serverErrors = []

    this.bindListeners
      handleSetTrainees:          HomePageActions.SET_TRAINEES
      handleSetCollectiveMembers: HomePageActions.SET_COLLECTIVE_MEMBERS

    this.exportPublicMethods
      getServerErrors:        this.getServerErrors
      getTrainees:            this.getTrainees
      getCollectiveMembers:   this.getCollectiveMembers

  handleSetCollectiveMembers: (data) ->
    this.collectiveMembers = data

  handleSetTrainees: (data) ->
    this.trainees = data

  # public methods

  getServerErrors: ->
    this.getState().serverErrors

  getTrainees: ->
    this.getState().trainees

  getCollectiveMembers: ->
    this.getState().collectiveMembers

module.exports = alt.createStore(HomePageStore, "HomePageStore")
