class Event < ActiveRecord::Base
  belongs_to :collective_member
  belongs_to :trainee

  scope :meeting, -> { where(meeting: true) }
  scope :training, -> { where.not(trainee: nil) }
  scope :normal, -> { where(trainee: nil }
end
