class Event < ActiveRecord::Base
  belongs_to :collective_member
  belongs_to :trainee

  scope :meeting, -> { where(meeting: true) }
  scope :training, -> { where.not(trainee: nil) }
  scope :normal, -> { where(trainee: nil).where(meeting: false) }

  def format
    event = Hash.new
    if self.meeting
      event["title"] = "Collective Meeting"
    else
      event["title"] = self.collective_member.first_name
    end
    event["start"] = self.start_time
    event["end"] = self.end_time
    event["allDay"] = false
    event["editable"] = true
    event
  end
end
