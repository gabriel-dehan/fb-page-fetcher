require 'minitest_helper'

describe 'Routes Acceptance Test' do
  describe '/' do
    it 'resolves to pages#index' do
      assert_routing '/', controller: 'pages', action: 'index'
    end
  end

  describe '/pages/:id' do
    it 'resolves to pages#show' do
      assert_routing '/pages/1', controller: 'pages', action: 'show', id: '1'
    end
  end

  describe '/pages' do
    it 'resolves to pages#create' do
      assert_routing({ path: '/pages', method: :post }, { controller: 'pages', action: 'create' })
    end
  end
end
