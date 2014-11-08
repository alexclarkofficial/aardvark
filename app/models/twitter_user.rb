class TwitterUser < ActiveRecord::Base
    has_many :songs
end
