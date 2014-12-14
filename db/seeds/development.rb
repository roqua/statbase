Datapoint.delete_all

metric_names = ['active_users', 'active_projects']
metrics = metric_names.map {|i| Metric.find_or_create_by! name: i }

scope_names  = ["bigco", 'spacely_sprockets'] + (0..5).map{ |i| "scope#{i}" }
scopes = scope_names.map {|i| Scope.find_or_create_by! name: i }

(0..20).each do |i|
  values = []
  date = i.days.ago.to_date
  data = {}

  metrics.each do |metric|
    data[metric.name] = {}

    scopes.each do |scope|
      value = nil

      case scope.name
      when 'bigco'
        value = rand()
      when 'spacely_sprockets'
        if (val = rand(10)) < 5
          value = val
        end
      else
        value = rand(10000)
      end

      if value
        values << "('#{date.to_s}', #{metric.id}, #{scope.id}, #{value})"
        data[metric.name][scope.name] = value
      end
    end
  end

  RecordData.new(date).record(data)

  # ActiveRecord::Base.connection.execute <<-SQL
  #   INSERT INTO datapoints ("date", "metric_id", "scope_id", "value") VALUES #{values.join(", ")};
  # SQL
end
