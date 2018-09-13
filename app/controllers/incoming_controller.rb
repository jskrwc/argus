class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]

  def create

    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    puts "Here is sender: #{params[:sender]}"
    puts "Here is subject: #{params[:subject]}"
    puts "Here is body-plain: #{params["body-plain"]}"


    # Find the user by using params[:sender]
    # Find the topic by using params[:subject]
    # Assign the url to a variable after retreiving it from params["body-plain"]

    @user = User.find_by(email: params[:sender])
    @topic = Topic.find_by(title: params[:subject])
    @url = params["body-plain"]

    # Check if user is nil, if so, create and save a new user
    if @user.nil?
      @user = User.new(email: params[:sender],password: "password")  #safe bc need authenticate?
      @user.save!
    end

    # Check if the topic is nil, if so, create and save a new topic
    if @topic.nil?
      @topic = @user.topics.build(title: params[:subject])
      @topic.save!
    end

    # Now that you're sure you have a valid user and topic, build and save a new video
    @video = @topic.video.build(url: @url)
    @video.save

    # Assuming all went well.
    head 200
  end
end
