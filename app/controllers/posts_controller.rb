class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @post = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = User.first # Change once I have authentication

    if @post.save
      flash[:notice] = "Felicidades, has publicado!"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "Exito, tu archivo se ha actualizado!"
      redirect_to posts_path(@post)
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
