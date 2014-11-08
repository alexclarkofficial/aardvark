class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :rdio_id

      t.timestamps
    end
  end
end
