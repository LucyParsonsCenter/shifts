class Trainee < ActiveRecord::Base
  has_and_belongs_to_many :events

  def select_format
    {value: self.id, label: "#{self.first_name} #{self.last_name}"}
  end

  def convert_to_collective_member
    trainee = self.serializable_hash
    trainee.delete("notes")
    trainee.delete("id")
    CollectiveMember.create!(trainee)
    Trainee.find_by_id(self.id).delete!
  end

end
