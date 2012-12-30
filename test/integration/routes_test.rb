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

  context 'api' do
    describe '/api/pages' do
     # The code here is much more complicated, as we already defined the route
      # for the root_path and assert_routing only retrieves the first match
      # between a route and a controller-action couple
      before {  get('/api/pages') }

      it 'should resolve' do
        response.status.must_equal 200
      end
      it 'resolves to articles#index' do
        request.parameters.must_equal({ "controller" => "pages", "action" => "index" })
      end
    end
  end
end
