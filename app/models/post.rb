class Post < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_one_attached :image
  validates :content, presence: true, length: { maximum: 1000 }

  def image_url(host: nil)
    return unless image.attached?

    if host.present?
      Rails.application.routes.url_helpers.rails_blob_url(image, host: host)
    else
      image.service_url
    end
  end
end
