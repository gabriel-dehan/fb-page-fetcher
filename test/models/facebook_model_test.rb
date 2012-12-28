# No need to load rake or rails
# Run with : ruby -Itest test/models/facebook_model_test.rb
require 'minitest_helper'

class DummyModel < Facebook::Model; end

class Facebook::DummyAunt < Facebook::Model
  has_one :dummy_child
end
class Facebook::DummyParent < Facebook::Model
  has_many :dummy_children
  has_one  :dummy_single_child
end

class Facebook::DummySingleChild < Facebook::Model
  belongs_to :dummy_parent
end
class Facebook::DummyChild < Facebook::Model
  belongs_to :dummy_parent
  belongs_to :dummy_aunt
end

describe Facebook::Model do
  context 'class methods' do
    it { DummyModel.must_respond_to :belongs_to }
    it { DummyModel.must_respond_to :has_many   }
    it { DummyModel.must_respond_to :has_one    }

    describe 'subclasses' do
      it 'must implement #build' do
        ->{ DummyModel.build }.must_raise(NotImplementedError)
      end
    end

    describe '#belongs_to' do
      it 'must add the class passed as an argument to the associations, as a parent' do
        DummyModel.belongs_to :test
        DummyModel.associations[:parents].must_include(:test)
      end
    end #belongs_to

    describe '#has_many, #has_one' do
      it 'must add the class passed as an argument to the associations, as a child' do
        DummyModel.has_many :tests
        DummyModel.has_one :test

        DummyModel.associations[:children].must_include(:tests)
        DummyModel.associations[:child].must_include(:test)
      end
    end #has_many, #has_one
  end

  context 'on instanciation with data' do
    before do
      @data = {
        dummy_children: [0, 1, 2],
        dummy_single_child: 8,
        dummy_parent: 1,
        dummy_aunt: 2
      }
    end
    describe 'associations' do
      before do
        @childs = []

        @data[:dummy_children].length.times do |i|
          @childs << Facebook::DummyChild.new
          Facebook::DummyChild.expects(:build).with(i).returns(@childs.last).at_least_once
        end

        @dummy_single_child = Facebook::DummySingleChild.new
        Facebook::DummySingleChild.expects(:build).with(@data[:dummy_single_child]).returns(@dummy_single_child).at_least_once
      end

      describe 'for has_many|one' do
        it 'must call the build method of the children with the data' do
          Facebook::DummyParent.new(@data)
        end
        it 'should create an instance method to get all children' do
          instance = Facebook::DummyParent.new(@data)

          instance.dummy_children.first.must_equal(@childs.first)
          instance.dummy_children.last.must_equal(@childs.last)

          instance.dummy_single_child.must_equal(@dummy_single_child)
        end
      end # has_many|one associations

      describe 'for belongs_to associations' do
        it 'should link to the existing instance of the parent' do
          instance = Facebook::DummyParent.new(@data)
          instance.dummy_children.last.dummy_parent.must_equal instance
        end
      end # belongs_to association
    end # associations
  end
end
