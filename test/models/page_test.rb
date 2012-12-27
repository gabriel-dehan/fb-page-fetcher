require "minitest_helper"

describe Page do
  before do
    @page = Page.new
  end

  it "must be valid" do
    @page.valid?.must_equal true
  end
end
