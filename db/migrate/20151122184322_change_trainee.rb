class ChangeTrainee < ActiveRecord::Migration
  def change
    change_table :trainees do |t|
      t.rename :trainee_name, :first_name
      t.text :last_name
    end
  end
end
