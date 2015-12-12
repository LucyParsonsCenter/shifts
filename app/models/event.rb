class Event < ActiveRecord::Base
  has_and_belongs_to_many :collective_members
  has_and_belongs_to_many :trainees

  scope :meeting, -> { where(meeting: true) }
  scope :training, -> { where.not(trainee_id: nil) }
  scope :normal, -> { where(trainee_id: nil).where(meeting: false) }

  def format
    event = Hash.new
    if self.meeting
      event["title"] = "Collective Meeting"
    else
      event["title"] = self.collective_members.first.try(:first_name)
    end
    event["start"] = self.start_time
    event["end"] = self.end_time
    event["allDay"] = false
    event["editable"] = true
    event
  end
end
