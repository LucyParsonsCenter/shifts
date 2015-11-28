class ChangeDatesOnEvents < ActiveRecord::Migration
  def change
    change_table :shifts do |t|
      t.remove :date_and_time
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
    end

    change_table :meetings do |t|
      t.remove :date_and_time
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
    end
  end
end
