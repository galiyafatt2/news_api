module Admin
  class NewsController < ApplicationController
    before_action :set_news, only: [:show, :edit, :update, :destroy]

    # GET /news
    def index
      @all_news = News.all
    end

    # GET /news/1
    def show
    end

    # GET /news/new
    def new
      @news = News.new
    end

    # GET /news/1/edit
    def edit
    end

    # POST /news
    def create
      @news = News.new(news_params)

      if @news.save
        NewsBroadcastJob.perform_later
        redirect_to [:admin, @news]
      else
        render :new
      end
    end

    # PATCH/PUT /news/1
    def update
      if @news.update(news_params)
        NewsBroadcastJob.perform_later
        redirect_to [:admin, @news]
      else
        render :edit
      end
    end

    # DELETE /news/1
    def destroy
      @news.destroy
      NewsBroadcastJob.perform_later
      redirect_to admin_news_index_url
    end

    private

    def set_news
      @news = News.find(params[:id])
    end

    def news_params
      params.require(:news).permit(:title, :content, :published_at, :visible, images: [])
    end
  end
end
