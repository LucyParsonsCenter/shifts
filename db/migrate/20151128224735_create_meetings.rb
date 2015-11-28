class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.text :notes
      t.datetime :date_and_time, null: false

      t.timestamps null: false
    end
  end
end
