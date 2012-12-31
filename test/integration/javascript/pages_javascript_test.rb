require 'minitest_helper'

describe 'Pages Javascript Integration Test' do
  before do
    visit root_path
  end

  context 'adding a new page' do
    before do
      DatabaseCleaner.clean

      @id = '218044128258628'
    end

    it 'must create a new page if the form is valid' do
      within('#new_page') do
        fill_in 'page_fb_uid', with: @id
      end
      click_button "add_page"
      Page.last.fb_uid.must_equal @id
    end

    it 'must display an error if the form invalidates' do
      within('#new_page') do
        fill_in 'page_fb_uid', with: ''
        click_button "add_page"
      end
      page.must have_css('div.alert-error')
    end

    it "must add the new page's name to the list", js: true do
      within('#new_page') do
        fill_in 'page_fb_uid', with: @id
      end
      click_button "add_page"
      ap Page.last
      page.must have_css('li', Page.last.name)
    end
  end
end
