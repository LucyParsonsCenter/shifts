class Event < ActiveRecord::Base
  has_and_belongs_to_many :collective_members
  has_and_belongs_to_many :trainees

  scope :meeting, -> { where(event_type: "meeting") }
  scope :training, -> { where(event_type: "training_shift") }
  scope :normal, -> { where(event_type: "shift") }
  scope :event, -> { where(event_type: "event") }

  def format
    event = Hash.new
    collective_members = self.collective_members.map { |c| "#{c.first_name} #{c.last_name}" }.join(", ")
    trainees = self.trainees.map { |t| "#{t.first_name} #{t.last_name}" }.join(", ")
    case self.event_type
    when "shift"
      event["title"] = collective_members
    when "training_shift"
      event["title"] = collective_members + " training: " + trainees
    when "meeting"
      event["title"] = "Collective Meeting"
    when "event"
      event["title"] = self.title
    end
    event["start"] = self.start_time
    event["end"] = self.end_time
    event["allDay"] = false
    event["editable"] = true
    event["id"] = self.id
    event
  end
end
