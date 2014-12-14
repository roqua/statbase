class MetricsController < ApplicationController
  def index
    @metrics = Metric.all
  end

  def show
    @metric = Metric.find params[:id]
    @scopes = @metric.scopes
    @datapoints = @metric.pivot_table
  end
end
