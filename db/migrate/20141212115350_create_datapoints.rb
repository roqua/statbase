class CreateDatapoints < ActiveRecord::Migration
  def change
    create_table :datapoints do |t|
      t.date   :date,   null: false
      t.string :metric, null: false
      t.string :scope,  null: false
      t.float  :value,  null: false
      t.timestamps
    end
  end
end
