class User < ApplicationRecord
  has_secure_token :api_token
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :followers, dependent: :destroy 
  has_many :favorites, dependent: :destroy

  def how_many_post
    user.posts.count
  end

  def how_many_followers
  end

  def how_many_follows
  end

end