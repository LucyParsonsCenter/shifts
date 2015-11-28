class Shift < ActiveRecord::Base
  belongs_to :collective_member
  belongs_to :trainee
end
