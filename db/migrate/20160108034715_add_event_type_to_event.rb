class AddEventTypeToEvent < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.text :event_type
    end
  end
end
