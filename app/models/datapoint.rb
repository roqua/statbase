class Datapoint < ActiveRecord::Base
  belongs_to :metric
  belongs_to :scope
end
