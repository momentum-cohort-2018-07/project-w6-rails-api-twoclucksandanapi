class API::PostsController < ApplicationController
  before_action :set_user, only: [:index, :show, :destroy]
  before_action :set_post, only: [:show, :repost, :destroy]

  def index
    @posts = @user.posts
    # render json: @posts
  end

  def show
    # render json: @post
  end

  def create
    if !current_user
      render json: {error: "Must be logged in to cluck"}
    else
      @post = Post.new(body: post_params[:body], user_id: current_user.id)
      if @post.save
        render :show, status: :created, location: api_rooster_cluck_url(current_user.id, @post.id)
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  end

  def repost
    if !current_user
      render json: {error: "Must be logged in to cluck"}
    else
      @post = Post.new(body: @post.body, user_id: current_user.id)
      if @post.save
        render :show, status: :created, location: api_rooster_cluck_url(current_user.id, @post.id)
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if current_user.id != @user.id
      render json: {error: "Must be the Rooster to Delete This Cluck"}
    else
      @post.destroy
      render json: @user.posts
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def set_user
    @user = User.find(params[:rooster_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end