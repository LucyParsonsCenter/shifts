request = require("superagent")

require('superagent-csrf')(request)

token = window._csrf

module.exports = {
  postEventForm: (data) ->
    request
      .post('/create_or_update_event')
      .send(EventFormStore.getFormData())
      .csrf(token)
      .set('Accept', 'application/json')
      .withCredentials()
      .end((err, res) ->
        if (res.ok)
          console.log('wooo')
        else
          console.log('not woo'))
}
