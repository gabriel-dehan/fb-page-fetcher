require "minitest_helper"

describe ApplicationHelper do
  describe '#get_title' do
    let(:application_name) { 'PageFetcher' }

    it 'must return the application name | title when a title is provided' do
      get_title('Foo').must_equal "#{application_name} | Foo"
    end
    it 'must return the application name alone if no title is provided an no action is defined' do
      get_title.must_equal "#{application_name}"
    end
    it 'must return the application name | current action if no title is provided and an action is defined' do
      self.stubs(:action_name).returns('index')
      self.get_title.must_equal "#{application_name} | Index"
    end
  end
end
