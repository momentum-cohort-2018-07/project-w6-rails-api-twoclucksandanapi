class API::PostsController < ApplicationController
  before_action :set_user, only: [:index, :show, :create, :destroy]
  before_action :set_post, only: [:show, :update, :destroy]

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
      @post = current_user.posts.create(post_params)
      # render json: @post
      render :show, status: :created, location: api_user_post_url(@user.id, @post.id)
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
    params.require(:post).permit(:body, :user_id)
  end
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
  def set_post
    @post = Post.find(params[:id])
  end 
end