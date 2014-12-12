# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

metric_names = ['active_users', 'active_projects']
scope_names  = ['bigco', 'spacely_sprockets']

(0..600).each do |i|
  date = i.days.ago.to_date

  metric_names.each do |metric|
    scope_names.each do |scope|
      Datapoint.create! date: date, metric: metric, scope: scope, value: 0
    end
  end
end
