# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
events = [{:title => 'Halloween Night', :tag => 'Others', :date => '31-Oct-2023', :location => 'Mudd'},
{:title => 'NWC Study', :tag => 'Computer Science', :date => '30-Oct-2023', :location=>'NWC'}
]

events.each do |event|
  Event.create!(event)
end

