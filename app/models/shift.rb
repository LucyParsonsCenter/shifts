class Shift < ActiveRecord::Base
  belongs_to :collective_member
  belongs_to :trainee

  scope :training, -> { where.not(trainee: nil) }
  scope :normal, -> { where(trainee: nil) }
end
