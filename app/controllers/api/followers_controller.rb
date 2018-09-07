class API::FollowersController < ApplicationController
before_action :set_follower, only: [:show, :destroy]

  # GET api/users/:user_id/followers
  def index
    @followers = Follower.all.where('user_id=?', params[:user_id])
  end

  # GET api/users/:user_id/follows
  def follows
    @followers = Follower.all.where('follower_id=?', params[:user_id])
  end

  # GET api/users/:user_id/followers/:follower_id
  def show
  end

  # POST api/users/:user_id/followers
  def create
    @follower = Follower.new(user_id: params[:user_id], follower_id: current_user.id)
    @user = @follower.user
    if @follower.save
      render :show, status: :created, location: api_user_follower_path(@user, @follower.follower_id)
    else
      render json: @follower.errors, status: :unprocessable_entity
    end
  end

  # DELETE api/users/:user_id/followers/:follower_id
  def destroy
    if current_user.id == @user.id || current_user.id == @follower.follower_id
      @follower.destroy
    else
      render json: { error: "You don't have permission to destroy this resource" }, status: :unauthorized
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_follower
      @follower = Follower.find_by_follower_id(params[:id])
      @user = User.find(params[:user_id])
    end

    # Only allow a trusted parameter "white list" through.
    def follower_params
      params.require(:follower).permit(:follower_id)
    end
end


