class UsersController < ApplicationController
  def show
    @user = current_user
    @user_videos = @user.videos
    @favorited_videos = @user.favorited_videos
  end

end
