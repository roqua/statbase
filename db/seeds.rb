# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Metric.delete_all
metric_names = ['active_users', 'active_projects']
metrics = metric_names.map {|i| Metric.create! name: i }

Scope.delete_all
scope_names  = ["bigco", 'spacely_sprockets'] + (0..5).map{ |i| "scope#{i}" }
scopes = scope_names.map {|i| Scope.create! name: i }

Datapoint.delete_all

(0..20).each do |i|
  values = []
  date = i.days.ago.to_date

  metrics.each do |metric|
    scopes.each do |scope|
      case scope.name
      when 'bigco'
        values << "('#{date.to_s}', '#{metric.id}', '#{scope.id}', #{rand()})"
      when 'spacely_sprockets'
        if (val = rand(10)) < 5
          values << "('#{date.to_s}', #{Datapoint.sanitize(metric.id)}, #{Datapoint.sanitize(scope.id)}, #{val})"
        else
          puts 'blank'
        end
      else
        values << "('#{date.to_s}', '#{metric.id}', '#{scope.id}', #{rand(10000)})"
      end
    end
  end

  ActiveRecord::Base.connection.execute <<-SQL
    INSERT INTO datapoints ("date", "metric_id", "scope_id", "value") VALUES #{values.join(", ")};
  SQL
end
