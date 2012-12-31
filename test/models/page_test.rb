require "minitest_helper"

describe Page do
  let(:page) { Page.new }

  its { page.must_respond_to :fb_uid }
  its { page.must_respond_to :name }
  its { page.must_respond_to :category }
  its { page.must_respond_to :picture }
  its { page.must_respond_to :likes }

  context 'validation' do
    before do
      page.fb_uid  = '25253'
      page.name     = 'One'
      page.category = nil
      page.picture  = nil
      page.likes    = 0
    end

    # Passing a parameter to valid? or invalid? is useless in this case
    # But we do it for the sake of clarity
    describe 'fb_uid' do
      it 'must be unique' do
        copy = page.clone
        copy.save

        page.invalid?.must_equal true
      end
      it 'must be present' do
        page.fb_uid = nil
        page.invalid?(:fb_uid).must_equal true
      end
      it "can't be blank" do
        page.fb_uid = ''
        page.invalid?(:fb_uid).must_equal true
      end
    end

    describe 'name' do
      it 'must be present' do
        page.name = nil
        page.invalid?(:name).must_equal true
      end
      it "can't be blank" do
        page.name = ''
        page.invalid?(:name).must_equal true
      end
    end

    describe 'category' do
      it 'can be missing' do
        page.valid?(:category).must_equal true
      end
      it 'can be blank' do
        page.category = ''
        page.valid?(:category).must_equal true
      end
    end

    describe 'picture' do
      it 'can be missing' do
        page.valid?(:picture).must_equal true
      end
      it 'can be blank' do
        page.picture = ''
        page.valid?(:picture).must_equal true
      end
    end

    describe 'likes' do
      it 'must be present' do
        page.likes = nil
        page.invalid?(:likes).must_equal true
      end
      it 'must be a number' do
        page.likes = 'foobar'
        page.invalid?(:likes).must_equal true
      end
    end

    # Everything should pass validation
    it "must be valid" do
      page.valid?.must_equal true
    end
  end
end
