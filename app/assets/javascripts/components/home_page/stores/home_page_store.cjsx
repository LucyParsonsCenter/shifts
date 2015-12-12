alt = require("../../shared/alt.js.coffee")
HomePageActions = require("../actions/home_page_actions.cjsx")

class HomePageStore
  constructor: ->
    this.formData = {}
    this.canSubmit = false
    this.serverErrors = []

    this.bindListeners
      handleSetCanSubmit:   HomePageActions.SET_CAN_SUBMIT
      handleFormChanged:    HomePageActions.FORM_CHANGED

    this.exportPublicMethods
      getCanSubmit:     this.getCanSubmit
      getFormData:      this.getFormData
      getServerErrors:  this.getServerErrors

  handleSetCanSubmit: (state) ->
    this.canSubmit = state

  handleFormChanged: (newData) ->
    this.formData[newData.key] = newData.value

  # public methods

  getCanSubmit: ->
    this.getState().canSubmit

  getFormData: ->
    this.getState().formData

  getServerErrors: ->
    this.getState().serverErrors

module.exports = alt.createStore(HomePageStore, "HomePageStore")
