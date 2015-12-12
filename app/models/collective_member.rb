class CollectiveMember < ActiveRecord::Base
  has_and_belongs_to_many :events

  def select_format
    {value: self.id, label: "#{self.first_name} #{self.last_name}"}
  end

end
