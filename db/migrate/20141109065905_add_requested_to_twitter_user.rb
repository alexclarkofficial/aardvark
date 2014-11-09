class AddRequestedToTwitterUser < ActiveRecord::Migration
  def change
    add_column :twitter_users, :request_count, :integer, default: 0
  end
end
