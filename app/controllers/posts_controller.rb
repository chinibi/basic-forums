class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :destroy]
  before_action :authorize
  before_action :only_my_posts, only: [:edit, :update]

  def index
    @posts = Post.all.order("created_at ASC")
  end

  def new
    @post = Post.new
    @topic = Topic.find(params[:topic_id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.topic = Topic.find(params[:topic_id])
    if @post.save
      flash[:notice] = "Post success"
      redirect_to topic_path(@post.topic)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated'
      redirect_to @post.topic
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to @post.topic
  end

  private
    def find_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :image_url)
    end

    def only_my_posts
      redirect_to @post.topic, notice: 'You may only modify your own posts' if (current_user != @post.user)
    end
end
