# frozen_string_literal: true

class NewsController < ApplicationController
  # GET /news
  def index
    @all_news = News.visible
    render json: @all_news.map { |news| NewsSerializer.new(news).as_json }
  end

  # GET /news/1
  def show
    @news = News.find(params[:id])
    render json: @news
  end
end
