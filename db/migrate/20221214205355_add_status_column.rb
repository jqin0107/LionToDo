class AddStatusColumn < ActiveRecord::Migration
    def change
      add_column :activities, :open_status, :string
    end
  end