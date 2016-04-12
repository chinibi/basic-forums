class TopicsController < ApplicationController
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
    def topic_params
      params.require(:topic).permit(:title, :content)
    end
end