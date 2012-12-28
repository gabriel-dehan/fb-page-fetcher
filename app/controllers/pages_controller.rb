class PagesController < ApplicationController
  def index
    @pages = Page.all
    @page  = Page.new
  end

  def create
    page = Page.new(fb_uid: params[:page][:fb_uid])
    page = Facebook::Page.build(page)

    if page.valid?
      page.save
    else
      flash[:error] = 'The page could not be saved'
    end
    redirect_to root_path
  end

  def show
    page  = Page.find(params[:id])
    @title = page.name

    @feed = Facebook::Feed.build(page)
  end
end
