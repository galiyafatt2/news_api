# app/serializers/news_serializer.rb
class NewsSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :content, :published_at, :visible, :images

  def images
    object.images.map do |image|
      rails_blob_url(image)
    end
  end
end
