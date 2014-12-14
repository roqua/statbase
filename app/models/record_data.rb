class RecordData
  attr_reader :date

  def initialize(date)
    @date = date
  end

  def record(data)
    data.each do |metric_name, metric_data|
      metric = ensure_metric(metric_name)

      metric_data.each do |scope_name, value|
        scope = ensure_scope(scope_name)

        Datapoint.create!(metric: metric, scope: scope, date: date, value: value)
      end
    end
  end

  def ensure_metric(name)
    @metrics_cache ||= {}
    @metrics_cache.fetch(name) do
      @metrics_cache[name] = Metric.find_or_create_by!(name: name)
    end
  end

  def ensure_scope(name)
    @scopes_cache ||= {}
    @scopes_cache.fetch(name) do
      @scopes_cache[name] = Scope.find_or_create_by!(name: name)
    end
  end
end
