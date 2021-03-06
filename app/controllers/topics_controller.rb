class TopicsController < ApplicationController

  before_action :authenticate_user!, except: (:index)

  def index
    @topics = Topic.includes(:videos).all  # load all upfront for n+1 efficiency
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user

    if @topic.save
      flash[:notice] = "Your Topic has been saved"
      redirect_to @topic
    else
      flash.now[:alert] = "There was an error creating your topic -- Please try again"
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Your Topic has been updated"
      redirect_to @topic
    else
      flash.now[:alert] = "There was an error updating your topic -- Please try again"
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    authorize @topic

    if @topic.destroy
      flash[:notice] = "\"#{@topic.title}\" was deleted successfully."
      redirect_to @topic
    else
      flash.now[:alert] = "There was an error deleting your topic.  Please try again."
      render :show
    end

  end

  private

  def topic_params
    params.required(:topic).permit(:title)
  end

end
