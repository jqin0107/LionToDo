class RemoveOrganizerFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :organizer, :string
  end
end
