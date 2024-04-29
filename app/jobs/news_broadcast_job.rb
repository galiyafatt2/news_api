# frozen_string_literal: true

class NewsBroadcastJob < ApplicationJob
  queue_as :default

  def perform
    ActionCable.server.broadcast 'news_channel', { news: render_news(News.visible) }
  end

  private

  def render_news(all_news)
    all_news.map { |news| NewsSerializer.new(news).as_json }
  end
end
