class AddAdultsOnlyToShowtime < ActiveRecord::Migration
  def change
    add_column :showtimes, :adults_only, :boolean
    add_column :showtimes, :is_3d, :boolean
  end
end
