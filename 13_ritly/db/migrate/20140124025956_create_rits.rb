class CreateRits < ActiveRecord::Migration
  def change
    create_table :rits do |t|
      t.string :code, :limit => 10
      t.string :link
      t.integer :visits

      t.timestamps
    end
  end
end
