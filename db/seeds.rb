# Create a goto (primary)  admin user
alpha1 = User.create!(
  email: 'alpha1@argus.today',
  password: 'password',
  role: 'admin',
  :confirmed_at => Time.now
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
#initial list, then some randoms..

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

video_list = %w{https://www.youtube.com/watch?v=au1rP52_KCY https://www.youtube.com/watch?v=TQhfamxklRI https://www.youtube.com/watch?v=zUwaQsI-V6k https://www.youtube.com/watch?v=ovE3L8Tbo70 https://www.youtube.com/watch?v=fa5SJKL4rlg https://www.youtube.com/watch?v=IykMgbgRPoc https://www.youtube.com/watch?v=MXV0FcrwoRY https://www.youtube.com/watch?v=DF6GfqG-IQE https://www.youtube.com/watch?v=MLvP6b0fwBQ https://www.youtube.com/watch?v=tqIKNCjXkY4 https://www.youtube.com/watch?v=u-m9ImII0pc https://www.youtube.com/watch?v=ObS7Q4Ul7lE}

40.times do
  video = Video.create!(
    user: users.sample,
    topic: topics.sample,
    url: video_list.sample
  )

  # update creation time
  video.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  #create 1-5 votes
  rand(1..5).times { video.votes.create!(value: [-1,1].sample, user: users.sample) }


end
videos = Video.all


# Create comments

100.times do
  Comment.create!(
    user: users.sample,
    video: videos.sample,
    body: Faker::ChuckNorris.fact
  )
end
comments = Comment.all



puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Video.count} videos created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
