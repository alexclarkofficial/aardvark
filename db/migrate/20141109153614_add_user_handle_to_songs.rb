class AddUserHandleToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :referer_handle, :string
  end
end
