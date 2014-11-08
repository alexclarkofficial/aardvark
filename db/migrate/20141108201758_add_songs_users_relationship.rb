class AddSongsUsersRelationship < ActiveRecord::Migration
  def change
    add_reference :songs, :twitter_user, index: true
  end
end
