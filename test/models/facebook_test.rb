# No need to load rake or rails
# Run with : ruby -Itest test/models/facebook_test.rb
require 'minitest_helper'

describe Facebook do
  # Mocking the Koala API
  let(:fb_page) { { 'name' => 'Mock', 'fb_uid' => '218044128258628', 'category' => 'Website', 'likes' => 17 } }
  let(:fb_feed) { [
      { 'id'       => '218044128258628',
        'message'  => 'Foobar foo',
        'likes'    => { 'count' => 0 },
        'shared'   => { 'count' => 1 },
        'picture'  => 'http://foo.bar',
        'link'     => nil,
        'created_time' => 'datetime1',
        'updated_at'   => 'datetime2',
        'from' => {
          'id' => '230249320942',
          'name' => 'Thomas'
        }
      },
      { 'id'       => '218044128258620',
        'message'  => 'Foobar bar',
        'likes'    => { 'count' => 18 },
        'shared'   => nil,
        'picture'  => nil,
        'link'     => 'http://bar.foo',
        'created_time' => 'datetime1',
        'updated_at'   => 'datetime2',
        'from' => {
          'id' => '230249320948',
          'name' => 'Ian'
        }
      }
    ]
  }
  before do
    graph = mock()
    graph.stubs(:get_object).with(fb_page['fb_uid']).returns(fb_page)
    graph.stubs(:get_connections).returns(fb_feed)
    graph.stubs(:get_picture).returns('http://foo.bar')
    Facebook.stubs(:connect).returns(graph)
  end

  it 'must respond to connect' do
    Facebook.must_respond_to :connect
  end

  # Facebook::Page
  describe Facebook::Page do
    it 'should have a build method' do
      Facebook::Page.must_respond_to :build
    end

    describe 'Facebook::Page::build' do
      before do
        @object = Struct.new(:fb_uid, :id, :name, :category, :picture, :likes).new(fb_page['fb_uid'])
      end

      it 'should raise an exception if a field is missing' do
        ->{ Facebook::Page.build Struct.new(:fb_uid, :id, :name, :picture, :likes).new(fb_page['fb_uid']) }.must_raise NoMethodError
      end

      it 'should return the same object it received as an argument' do
        Facebook::Page.build(@object).must_equal @object
      end

      describe 'returns a filled object' do
        let(:o) { Facebook::Page.build(@object) }
        its { o.name.must_equal fb_page['name'] }
        its { o.category.must_equal fb_page['category'] }
        its { o.picture.must_equal fb_page['picture'] }
        its { o.likes.must_equal fb_page['likes'] }
      end
    end
  end

  # Facebook::Feed
  describe Facebook::Feed do
    it 'should have a build method' do
      Facebook::Feed.must_respond_to :build
    end

    describe '#build' do
      let(:feed) { Facebook::Feed.build(Page.new(fb_uid: fb_page['fb_uid'])) }

      it 'should have a list of comments' do
        feed.comments.last.message.must_equal(fb_feed.last['message'])
      end
      it 'each comment should have an author' do
        feed.comments.first.author.name.must_equal(fb_feed.first['from']['name'])
      end
    end
  end
end
