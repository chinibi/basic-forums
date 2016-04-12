class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.topic = Topic.find(params[:topic_id])
    if @post.save
      flash[:notice] = "Post success"
      redirect_to @post.topic
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to '/topics/:id'
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
