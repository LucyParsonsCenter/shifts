class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :events, :collective_members do |t|
      t.index [:event_id, :collective_member_id], name: "fooop"
      t.index [:collective_member_id, :event_id], name: "why"
    end

    create_join_table :events, :trainees do |t|
      t.index [:event_id, :trainee_id], name: "flasdf"
      t.index [:trainee_id, :event_id], name: "foobar"
    end

    remove_column :events, :collective_member_id
  end
end
