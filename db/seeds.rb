# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create a goto (primary) user
alpha1 = User.create!(
  email: 'alpha1@argus.today',
  password: 'password',
  confirmed_at: Time.now
)

#  Create users
6.times do
  User.create!(
    :email => Faker::Internet.email,
    :password => Faker::Internet.password,
    :confirmed_at => Time.now
  )
end
users = User.all

# Create topics
#initial list:

topic_list = %w{Police\ Misconduct Referee\ Abuse Bullying Polluters Fare\ Evasion Prostitution/Soliciting DUI}

topic_list.each do |topic|
  Topic.create!(
    user: users.first,
    title: topic
  )
end

5.times do
  Topic.create!(
    user: users.sample,
    title: Faker::Book.title
  )
end
topics = Topic.all

# Create videos
# sample list of Videos

video_list = %w{https://www.youtube.com/watch?v=au1rP52_KCY https://www.youtube.com/watch?v=fa5SJKL4rlg https://www.youtube.com/watch?v=IykMgbgRPoc https://www.youtube.com/watch?v=MXV0FcrwoRY https://www.youtube.com/watch?v=DF6GfqG-IQE https://www.youtube.com/watch?v=MLvP6b0fwBQ https://www.youtube.com/watch?v=tqIKNCjXkY4 https://www.youtube.com/watch?v=u-m9ImII0pc https://www.youtube.com/watch?v=ObS7Q4Ul7lE}
20.times do
  Video.create!(
    topic: topics.sample,
    url: video_list.sample
  )
end
videos = Video.all


puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Video.count} videos created"
