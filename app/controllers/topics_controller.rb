class TopicsController < ApplicationController
  before_action :find_topic, only: [:edit, :show, :destroy]
  before_action :authorize, only: [:new, :edit, :destroy]
  before_action :only_my_posts, only: [:edit, :update, :destroy]

  def index
    @topics = Topic.all.order("updated_at DESC")
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    if @topic.save
      flash[:notice] = "Thread created"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
  end

  private
    def find_topic
      @topic = Topic.find(params[:id])
    end

    def topic_params
      params.require(:topic).permit(:title, :content, :image_url)
    end

    def only_my_topics
      redirect_to root_path, notice: 'You may only modify your own posts' if (current_user != @topic.user)
    end
end
