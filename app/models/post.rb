class Post < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_one_attached :image

  validates :content, presence: true, length: { maximum: 1000 }

  def rotate
    image.variant(rotate: "-180", draw: "text 0,0 'hoge'")
  end

  def resize
    variation = ActiveStorage::Variation.new(
      PostsHelper.build(content)
    )
    ActiveStorage::Variant.new(image.blob, variation)
  end
end
