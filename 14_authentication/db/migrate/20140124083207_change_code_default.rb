class ChangeCodeDefault < ActiveRecord::Migration
  def change
  	change_column :rits, :code, :string, :limit => 25
  end
end
