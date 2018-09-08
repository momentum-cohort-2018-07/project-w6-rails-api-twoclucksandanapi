class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites
  validates :body, length: { in: 2..280 } 
end
