class Metric < ActiveRecord::Base
  has_many :datapoints

  def scopes
    @scope_ids ||= datapoints.select(:scope_id).distinct.order(:scope_id).pluck(:scope_id)
    @scopes    ||= Scope.where(id: @scope_ids)
  end

  def pivot_table
    if scopes.any?
      columns = scopes.map {|i| "\"#{i.id}\" float" }.join(", ")
      sql = <<-SQL
        SELECT * FROM crosstab(
          $$SELECT date, scope_id, value FROM datapoints WHERE metric_id = #{ActiveRecord::Base.connection.quote(id)}$$,
          'SELECT DISTINCT scope_id FROM datapoints ORDER BY scope_id'
        ) AS ct("date" date, #{columns})
        ORDER BY date DESC;
      SQL
      datapoints = ActiveRecord::Base.connection.execute(sql).to_a.group_by{|i| i["date"] }
    else
      datapoints = []
    end
  end
end
