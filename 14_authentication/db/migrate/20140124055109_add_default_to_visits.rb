class AddDefaultToVisits < ActiveRecord::Migration
  def change
  	change_column :rits, :visits, :integer, :default => 0
  end
end
