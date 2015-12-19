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
      selectable: true,
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
          endNode.value = start.format('HH:mm')
          endNode.dispatchEvent(eventToBubble)

        $('#fullcalendar-modal').modal()

      eventClick:  (event, jsEvent, view) ->
        eventNode = document.getElementById('eventID')
        eventNode.value = event.id
        eventToBubble = new Event('input', { bubbles: true })
        eventNode.dispatchEvent(eventToBubble)
        $('#fullcalendar-modal').modal()

      # dayClick: (date, jsEvent, view) ->
      #   console.log("day")

      #   eventNode = document.getElementById('eventID')
      #   eventNode.value = ""
      #   eventToBubble = new Event('input', { bubbles: true })
      #   eventNode.dispatchEvent(eventToBubble)


      #   eventDateHack = document.getElementById('dateHack')
      #   eventDateHack.value = date.format('YYYY-MM-DD')
      #   eventDateHack.dispatchEvent(eventToBubble)
      #   $('#fullcalendar-modal').modal()
    }
  )
