class PagesController < ApplicationController
  caches_action :show, expires_in: 15.minute

  def index
    @pages = Page.all.reverse
    @page  = Page.new

    respond_to do |format|
      format.html
      format.json { render json: @pages }
    end
  end

  def create
    status = 200

    _page  = Page.new(fb_uid: params[:page][:fb_uid])
    page   = Facebook::Page.build(_page)

    unless page.valid? and page.save
      status = 422
      flash[:error] = 'The page could not be saved'
    end

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render json: { error: flash[:error] }, status: status }
    end
  end

  def show
    page  = Page.find(params[:id])
    @title = page.name

    @feed = Facebook::Feed.build(page)
  end
end
