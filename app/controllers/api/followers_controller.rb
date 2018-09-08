class API::FollowersController < ApplicationController
  before_action :set_follower, only: [:show, :destroy]

  # GET api/users/:user_id/followers
  def index
    @followers = Follower.all.where('user_id=?', params[:rooster_id])
  end

  # GET api/users/:user_id/follows
  def follows
    @followers = Follower.all.where('follower_id=?', params[:rooster_id])
  end

  # GET api/users/:user_id/follows/:follows_id
  def follows_show
    @follower = Follower.where('user_id=?', params[:follows_id]).where('follower_id=?', params[:rooster_id])[0]
    @user = User.find(params[:follows_id])
    if !@follower
      render json: {error: "You are not following #{@user.username}"}, status: :conflict
    end
  end

  def follows_posts
    @followers = Follower.all.where('follower_id=?', current_user.id)
    @posts = @followers.map { |follower| follower.user.posts }.flatten
  end

  # GET api/users/:user_id/followers/:follower_id
  def show
  end

  # POST api/users/:user_id/followers
  def create
    if Follower.where('user_id=?', params[:rooster_id]).where('follower_id=?', current_user.id)[0]
      render json: {error: "You can't follow the same user twice."}, status: :conflict
    else
      @follower = Follower.new(user_id: params[:rooster_id], follower_id: current_user.id)
      @user = @follower.user
      if @follower.save
        render :show, status: :created, location: api_rooster_follower_path(@user, @follower.follower_id)
      else
        render json: @follower.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE api/users/:user_id/followers/:follower_id
  def destroy
    if current_user.id == @user.id || current_user.id == @follower.follower_id
      @follower.destroy
    else
      render json: {error: "You don't have permission to destroy this resource"}, status: :unauthorized
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_follower
    @follower = Follower.where('user_id=?', params[:rooster_id]).where('follower_id=?', params[:id])[0]
    @user = User.find(params[:rooster_id])
  end

  # Only allow a trusted parameter "white list" through.
  def follower_params
    params.require(:follower).permit(:follower_id)
  end
end


