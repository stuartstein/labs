class CreateCreatures < ActiveRecord::Migration
  def change
    create_table :creatures do |t|
      t.string :name
      t.string :description
      t.string :picture

      t.timestamps
    end
  end
end
