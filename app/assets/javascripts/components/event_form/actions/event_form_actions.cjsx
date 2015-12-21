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
    )

  idChanged: (id) ->
    console.log(id)
    if id != ""
      $.getJSON("/events/#{id}", (data) ->
        # this.setFormState(data)
        this.setID(id)
        $('#fullcalendar-modal').modal()
      )
    else
      this.setID(id)
      $('#fullcalendar-modal').modal()

module.exports = alt.createActions(EventFormActions)
