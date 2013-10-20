class CreateCinemas < ActiveRecord::Migration
  def change
    create_table :cinemas do |t|
      t.string :name
      t.references :city, index: true
      t.string :website

      t.timestamps
    end
    add_index :cinemas, :name, unique: true
  end
end
