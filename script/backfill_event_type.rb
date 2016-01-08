Event.all.each do |event|
  if !event.event_type
    if event.meeting
      event.update(event_type: "meeting")
    elsif event.title
      event.update(event_type: "event")
    elsif event.trainees != []
      event.update(event_type: "training_shifts")
    else
      event.update(event_type: "shift")
    end
  end
end
