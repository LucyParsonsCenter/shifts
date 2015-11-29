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
          url: '/meetings_feed',
          color: 'pink',
          textColor: 'black'
        }
      ],
      header: {
        left: 'today prev,next'
        center: 'title',
        right: 'month,agendaWeek,agendaDay',
      },
      eventClick:  (event, jsEvent, view) ->
        $('#edit-modal-title').html(event.title)
        $('#edit-modal-body').html(event.description)
        $('#edit-eventUrl').attr('href',event.url)
        $('#fullcalendar-edit-modal').modal()
      dayClick: (date, jsEvent, view) ->
        $('#new-modal-title').html(event.title)
        $('#new-modal-body').html(event.description)
        $('#edit-eventUrl').attr('href',event.url)
        $('#fullcalendar-new-modal').modal()
    }
  )
