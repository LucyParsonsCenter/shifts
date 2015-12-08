class Trainee < ActiveRecord::Base
  has_many :events

  def select_format
    {value: self.id, label: "#{self.first_name} #{self.last_name}"}
  end

end
