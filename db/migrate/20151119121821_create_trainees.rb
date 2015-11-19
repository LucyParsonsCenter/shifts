class CreateTrainees < ActiveRecord::Migration
  def change
    create_table :trainees do |t|
      t.text :trainee_name
      t.text :email_address
      t.text :phone_number
      t.text :notes

      t.timestamps null: false
    end
  end
end
