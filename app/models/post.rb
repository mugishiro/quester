class Post < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_one_attached :image
  validates :content, presence: true, length: { maximum: 1000 }

  def image_url
    image.attachment.service.send(:object_for, image.key).public_url
  end
end
