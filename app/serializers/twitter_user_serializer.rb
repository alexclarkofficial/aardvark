class TwitterUserSerializer < ActiveModel::Serializer
  attributes :handle, :name, :image_url
  has_many :songs
  has_many :friends
end
