class User < ApplicationRecord
  has_secure_token :api_token
  has_secure_password
  validates :username, presence: true, uniqueness: true
  has_many :posts, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_many :favorites, dependent: :destroy
end