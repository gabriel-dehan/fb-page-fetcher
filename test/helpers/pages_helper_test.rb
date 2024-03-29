require "minitest_helper"

describe PagesHelper do
  describe '#facebook_picture' do
    let(:page) { Page.where(fb_uid: '218040571591504').first }
    it 'must return the original page picture if the type is small' do
      ap page
      facebook_picture(page).must_equal image_tag page.picture
    end

    it 'must return the graph link for the other types' do
      facebook_picture(page, type: :large).must_equal image_tag "https://graph.facebook.com/#{page.fb_uid}/picture?type=large"
    end
  end

  describe '#get_time' do
    it 'should convert a time string into a time ago in words' do
      time_string = (Time.now - 15.hours).to_s
      get_time(time_string).must_equal "about 15 hours"
    end
  end

  describe '#maybe_nil' do
    it 'returns 0 if the value is nil' do
      maybe_nil(nil).must_equal 0
    end
    it 'returns the value if the value is not nil' do
      maybe_nil(6).must_equal 6
    end
  end

  describe '#display_content_for' do
    before do
      @s_comment = Struct.new(:picture, :message, :link)
    end
    it 'must return an image embeded in a link and the message if there is a picture' do
      comment = @s_comment.new('http://foo', 'bar', 'buz')
      display_content_for(comment).must_equal '<a href="buz"><img alt="Foo" src="http://foo" /></a>bar'
    end
    it 'must return an the message embeded in a link if there is no picture' do
      comment = @s_comment.new(nil, 'bar', 'buz')
      display_content_for(comment).must_equal '<a href="buz">bar</a>'
    end
  end
end
