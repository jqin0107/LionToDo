class CreateDb < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :first_name
      t.string :last_name
      t.string :password_digest
    create_table :events do |t|
      t.string :title
      t.string :tag
      t.datetime :date
      t.string :location
      t.timestamps null: false
    end
  end
end
