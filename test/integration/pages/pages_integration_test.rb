require 'minitest_helper'

describe "Pages Integration Test" do
  describe 'index' do
    before do
      visit root_path
    end
    let(:form) { '#new_page' }

    describe 'New page form' do
      it 'must have a form to add a new page' do
        page.must have_selector("form#{form}")
      end

      context 'New page creation' do
        it 'should create a new page if the form validates' do
          id = '218044128258628'
          within(form) do
            fill_in 'page_fb_uid', with: id
            click_button "add_page"
          end
          Page.last.fb_uid.must_equal id
        end # should create a new page

        it 'should display an error if the form invalidates' do
          within(form) do
            fill_in 'page_fb_uid', with: ''
            click_button "add_page"
          end
          page.must have_css('div.alert-error')
        end # should display error

      end # New page creation
    end # New page form

    describe 'Page list' do
      it 'should display a list of all pages' do
        [Page.first, Page.last].each do |p|
          page.must have_css('li', text: p.name)
        end
      end
    end # Page list
  end # index

  describe 'show' do
  end # show
end
