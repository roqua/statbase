class ConvertMetricToModel < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.string :name
      t.timestamps
    end

    add_column :datapoints, :metric_id, :integer, after: 'metric'
    remove_column :datapoints, :metric
  end
end
