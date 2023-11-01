# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
activities = [{:event_name => 'Halloween Night', :creator_id => 1, :max_size => 10, :current_size =>10, :category => 'Entertainment', :date => '31-Oct-2022', :location => 'Columbia University', :open_status=>'Open'},
{:event_name => 'Met Sunday', :creator_id => 2, :max_size => 4, :current_size =>1, :category => 'Arts', :date => '30-Oct-2022', :location=>'Met Museum', :open_status => 'Open'}
]
users = [
	{:user_name => 'tester1', :first_name => 'first tester1', :last_name => 'last tester1', :password => 'tstpwd1'},
	{:user_name => 'tester2', :first_name => 'first tester2', :last_name => 'last tester2', :password => 'tstpwd2'}
]
follows = [
	{:follower => 1, :followee => 2}
]
activities.each do |activity|
  Activity.create!(activity)
end

users.each do |user|
	User.create!(user)
end