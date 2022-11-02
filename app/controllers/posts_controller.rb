class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).all

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post].permit(:title, :content, :address))
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

end
