class VideosController < ApplicationController

  before_action :authenticate_user!

  def show
    @video = Video.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @video = Video.new
  end

  def edit
    @video = Video.find(params[:id])
    @topic = @video.topic
  end

  def create
    @video = Video.new(video_params)

    @topic = Topic.find(params[:topic_id])
    @video.topic = @topic

    if @video.save
      flash[:notice] = "Video has been saved"
      redirect_to @video.topic
    else
      flash.now[:alert] = "There was an error creating the video -- Please try again"
      render :new
    end
  end

  def update
    @video = Video.find(params[:id])
    # @video.url = params[:video][:url]
    @video.assign_attributes(video_params)

    if @video.save
      flash[:notice] = "The Video has been updated"
      redirect_to @video.topic
    else
      flash.now[:alert] = "There was an error updating the video -- Please try again"
      render :edit
    end
  end

  def destroy
    @video = Video.find(params[:id])

    if @video.destroy
      flash[:notice] = "\"#{@video.video_id}\" was deleted successfully."
      redirect_to @video.topic
    else
      flash.now[:alert] = "There was an error deleting the video.  Please try again."
      render :show
    end

  end

  private

  def video_params
    params.required(:video).permit(:url)
  end

end
