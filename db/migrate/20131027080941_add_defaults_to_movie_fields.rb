class AddDefaultsToMovieFields < ActiveRecord::Migration
  def change
  	change_column :movies, :language, :string, :default => 'English'
  end
end
