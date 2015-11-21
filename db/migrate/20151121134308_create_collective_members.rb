class CreateCollectiveMembers < ActiveRecord::Migration
  def change
    create_table :collective_members do |t|
      t.text :first_name, null: false
      t.text :last_name
      t.text :email_address
      t.text :phone_number
      t.boolean :trainer

      t.timestamps null: false
    end
  end
end
