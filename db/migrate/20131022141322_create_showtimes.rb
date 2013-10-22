class CreateShowtimes < ActiveRecord::Migration
  def change
    create_table :showtimes do |t|
      t.references :movie, index: true
      t.references :cinema, index: true
      t.datetime :showing_at

      t.timestamps
    end
  end
end
