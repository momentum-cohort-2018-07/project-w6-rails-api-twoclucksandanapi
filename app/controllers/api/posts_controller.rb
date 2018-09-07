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
    @post = @user.posts.create(post_params)
    render json: @post
  end
  
  def destroy
    @post.destroy
    render json: @user.posts
  end
  
  private 
  def post_params
    params.require(:post).permit(:body)
  end
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
  def set_post
    @post = Post.find(params[:id])
  end 
end