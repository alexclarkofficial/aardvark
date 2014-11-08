class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :handle
      t.string :name
      t.string :image_url

      t.timestamps
    end
  end
end
