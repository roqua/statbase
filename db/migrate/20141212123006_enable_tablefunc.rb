class EnableTablefunc < ActiveRecord::Migration
  def change
    enable_extension 'tablefunc'
  end
end
