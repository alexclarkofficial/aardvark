# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TwitterUser.destroy_all
Song.destroy_all

user1 = TwitterUser.create(
    handle:'@test_handle',
    name:'@test_name'
)
song1 = Song.create([
    {
        rdio_id:'ASDF2134',
        twitter_user: user1
    }
])