class PagesController < ApplicationController
  def index
    @pages = Page.all
    @page  = Page.new
  end
end
