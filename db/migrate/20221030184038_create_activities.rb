class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :event_name
      t.string :organizer
      t.integer :max_size
      t.integer :current_size
      t.text :description
      t.string :category
      t.datetime :date
      t.string :location

      t.timestamps null: false
    end
  end
end
