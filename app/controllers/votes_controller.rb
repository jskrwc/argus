class VotesController < ApplicationController
    before_action :authenticate_user!

    def up_vote
      update_vote(1)
      redirect_back(fallback_location: :root)
    end

    def down_vote
      update_vote(-1)
      redirect_back(fallback_location: :root)
    end

    private
    def update_vote(new_value)
      @video = Video.find(params[:video_id])
      @vote = @video.votes.where(user_id: current_user.id).first
      if @vote
        @vote.update_attribute(:value, new_value)
      else
        @vote = current_user.votes.create(value: new_value, video: @video)
      end
    end

end
