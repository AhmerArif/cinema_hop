class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :slug
      t.string :imdb_link
      t.string :rotten_tomatoes_link

      t.timestamps
    end
    add_index :movies, :slug
  end
end
