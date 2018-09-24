class CommentsController < ApplicationController

  before_action :authenticate_user!, except: (:show)

  def create
    @video = Video.find(params[:video_id])
    comment = @video.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment successfully saved."
    else
      flash[:alert] = "Comment failed to save."
    end
    redirect_to [@video.topic, @video]
  end

  def destroy
    @video = Video.find(params[:video_id])
    comment = @video.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted"
    else
      flash[:alert] = "Comment couldn't be deleted -- try again"
    end
    redirect_to [@video.topic, @video]
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
