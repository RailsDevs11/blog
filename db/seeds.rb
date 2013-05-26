# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(first_name: 'admin', last_name: 'test', username: 'admin', 
  email: 'admin@example.com', password: '123456', password_confirmation: '123456')

post = Post.create(user_id: user.id, title: 'Testing to post', content: 'This file should contain all the test record')

comment = Comment.create(post_id: post.id, content: 'This is testing records for comments')
