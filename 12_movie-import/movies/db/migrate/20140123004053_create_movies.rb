class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :plot
      t.string :year
      t.string :poster
      t.string :imdbID

      t.timestamps
    end
  end
end
