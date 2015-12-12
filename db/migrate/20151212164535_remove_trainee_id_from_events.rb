class RemoveTraineeIdFromEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.remove :trainee_id
    end
  end
end
