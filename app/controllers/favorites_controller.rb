class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    video = Video.find(params[:video_id])
    favorite = current_user.favorites.build(video: video)

    if favorite.save
      flash[:notice] = "Video favorited."
    else
      flash[:alert] = "Video favoriting failed."
    end
    redirect_to [video.topic, video]
  end

  def destroy
    video = Video.find(params[:video_id])
    favorite = current_user.favorites.find(params[:id])

    if favorite.destroy
      flash[:notice] = "Video unfavorited."
    else
      flash[:alert] = "Video unfavoriting failed."
    end
    redirect_to [video.topic, video]
  end

end
