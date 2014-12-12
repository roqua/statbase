class AddUniquenessConstraintDatapoints < ActiveRecord::Migration
  def change
    add_index :datapoints, [:date, :metric, :scope], unique: true
  end
end
