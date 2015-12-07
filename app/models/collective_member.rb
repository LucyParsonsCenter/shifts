class CollectiveMember < ActiveRecord::Base

  def select_format
    {value: self.id, label: "#{self.first_name} #{self.last_name}"}
  end

end
