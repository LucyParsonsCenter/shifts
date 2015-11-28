class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.integer :collective_member_id, null: false
      t.integer :trainee_id
      t.datetime :date_and_time, null: false

      t.timestamps null: false
    end

    add_foreign_key :shifts, :collective_members
    add_foreign_key :shifts, :trainees
  end
end
