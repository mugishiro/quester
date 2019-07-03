class Post < ApplicationRecord
  belongs_to :user
  has_many :replies
  
  validates :content, presence: true, length: { maximum: 1000 }
end