class ConvertScopeToModel < ActiveRecord::Migration
  def change
    create_table :scopes do |t|
      t.string :name
      t.timestamps
    end

    add_column :datapoints, :scope_id, :integer, after: 'scope'
    remove_column :datapoints, :scope
  end
end
