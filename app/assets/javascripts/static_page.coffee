# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#calendar').fullCalendar(
    {
      eventSources: [
        { # here we set up the API endpoints for our different shifts
          url: '/normal_shifts',
          color: 'blue',
          textColor: 'black'
        },
        {
          url: '/training_shifts',
          color: 'yellow',
          textColor: 'black'
        },
        {
          url: '/meetings',
          color: 'pink',
          textColor: 'black'
        }
      ]
    }
  )
