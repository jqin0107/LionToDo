class CreateActivityUserRelation < ActiveRecord::Migration
  def change
    create_table :activity_user_relations do |t|
      t.integer :user_id
      t.integer :activity_id
    end
  end
end
