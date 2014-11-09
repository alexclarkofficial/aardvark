class TwitterUser < ActiveRecord::Base
  has_many :songs
  default_scope -> { order('request_count desc')}
end
