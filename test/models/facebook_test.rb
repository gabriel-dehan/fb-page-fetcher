# No need to load rake or rails
# Run with : ruby -Itest test/models/facebook_test.rb
require 'minitest_helper'

describe Facebook do
  # Mocking the Koala API
  let(:fb_page) { { name: 'Mock', fb_uid: '218044128258628', category: 'Website', likes: 17 } }
  before do
    graph = stub(get_object: fb_page)
    Facebook.stubs(:connect).returns(graph)
  end

  it 'must respond to connect' do
    Facebook.must_respond_to :connect
  end

  # Facebook::Page
  describe Page do
    it 'should have a build method' do
      Facebook::Page.must_respond_to :build
    end

    describe 'Facebook::Page::build' do
      before do
        @object = Struct.new(:fb_uid, :id, :name, :category, :picture, :likes).new(fb_page[:fb_uid])
      end

      it 'should raise an exception if a field is missing' do
        ->{ Facebook::Page.build Struct.new(:fb_uid, :id, :name, :picture, :likes).new }.must_raise NoMethodError
      end

      it 'should return the same object it received as an argument' do
        Facebook::Page.build(@object).must_equal @object
      end

      describe 'returns a filled object' do
        let(:o) { Facebook::Page.build(@object) }
        its { o.name.must_equal fb_page[:name] }
        its { o.category.must_equal fb_page[:category] }
        its { o.picture.must_equal fb_page[:picture] }
        its { o.likes.must_equal fb_page[:likes] }
      end
    end
  end
end
