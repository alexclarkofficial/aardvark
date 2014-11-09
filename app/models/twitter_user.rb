class TwitterUser < ActiveRecord::Base
  has_many :songs
  has_many :friends
  default_scope -> { order('request_count desc')}
end
