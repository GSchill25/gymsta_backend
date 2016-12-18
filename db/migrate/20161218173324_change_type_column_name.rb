class ChangeTypeColumnName < ActiveRecord::Migration
  def change
  	rename_column :exercises, :type, :etype
  end
end
