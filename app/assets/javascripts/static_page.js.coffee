# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#calendar').fullCalendar(
    {
      defaultView: 'agendaWeek',
      eventSources: [
        { # here we set up the API endpoints for our different shifts
          url: '/normal_shifts',
          color: '#9FC6E7',
          textColor: 'black'
        },
        {
          url: '/training_shifts',
          color: '#9EA0FF',
          textColor: 'black'
        },
        {
          url: '/meetings_feed',
          color: '#F691B2',
          textColor: 'black'
        },
        {
          url: '/events_feed',
          color: '#B3DC6C',
          textColor: 'black'
        }
      ],
      header: {
        left: 'today prev,next'
        center: 'title',
        right: 'month,agendaWeek,agendaDay',
      },
      selectable: true,
      nowIndicator: true,
      selectHelper: true,

      select: (start, end) ->
        # reset event ID to clear form
        eventNode = document.getElementById('eventID')
        eventNode.value = ""
        eventToBubble = new Event('input', { bubbles: true })
        eventNode.dispatchEvent(eventToBubble)

        # set the date
        eventDateHack = document.getElementById('dateHack')
        eventDateHack.value = start.format('YYYY-MM-DD')
        eventDateHack.dispatchEvent(eventToBubble)

        if start.hasTime() # is a time range selection
          startNode = document.getElementById('startHack')
          startNode.value = start.format('HH:mm')
          startNode.dispatchEvent(eventToBubble)
          endNode = document.getElementById('endHack')
          endNode.value = end.format('HH:mm')
          endNode.dispatchEvent(eventToBubble)

        $('#fullcalendar-modal').modal()

      eventClick:  (event, jsEvent, view) ->
        eventNode = document.getElementById('eventID')
        eventNode.value = event.id
        eventToBubble = new Event('input', { bubbles: true })
        eventNode.dispatchEvent(eventToBubble)
    }
  )

  $('#calendar').fullCalendar('option', 'contentHeight', "auto");
