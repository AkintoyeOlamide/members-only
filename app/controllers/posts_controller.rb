class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash.notice = "Post created!"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash.notice = "Post '#{@post.title}' deleted!"
    redirect_to root
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
