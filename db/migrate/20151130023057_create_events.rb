class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :collective_member_id
      t.integer :trainee_id
      t.boolean :meeting, default: false
      t.text :notes
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false

      t.timestamps null: false
    end

    drop_table :shifts
    drop_table :meetings
  end
end
