class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :name
      t.string :handle
      t.string :image_url
      t.belongs_to :twitter_user, index: true

      t.timestamps
    end
  end
end
