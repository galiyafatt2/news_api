class News < ApplicationRecord
  has_many_attached :images

  validates :title, :content, presence: true
  validate :correct_image_mime_type

  scope :visible, -> { where(visible: true) }

  private

  def correct_image_mime_type
    images.each do |image|
      unless image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:images, 'must be a JPEG or PNG')
      end
    end
  end
end
