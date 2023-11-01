class Activity < ActiveRecord::Base
	validates :event_name, presence: true
	validates :location, presence: true
	validates :max_size, presence: true
	validates :current_size, presence: true
	validates :category, presence: true
	validates :open_status, presence: true

	def self.all_categories
		['Arts', 'Entertainment', 'Education', 'Sports', 'Outdoor', 'Others']
	end

	def self.with_categories(category_list, sort_by)
			Activity.where("category in(?)", category_list).order sort_by
	end
end
