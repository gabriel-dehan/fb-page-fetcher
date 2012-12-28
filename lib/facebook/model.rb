# Public: Facebook::Model, implements a naive version of ActiveRecord has_one, has_many, belongs_to
# Currently, objects can only have one parent through belongs_to.
class Facebook::Model
  include ActiveSupport::Inflector

  # Public: Initialize a Facebook::Model instance and call the build method for each association
  # For examples see ::has_one or ::has_many.
  #
  # data - A Hash containg the data for each association that needs to be built.
  #
  # Returns a Facebook::Model instance.
  def initialize data = nil
    build_child_with data    if associations[:child]
    build_children_with data if associations[:children]
  end

  # Public: Get the current class instance's associations and caches them.
  #
  # Returns an Hash of Arrays.
  def associations
    @associations ||= self.class.associations || {}
  end

  # Internal: Build the associated class for each has_many association,
  # according to the data. Also defines a corresponding attr_reader to get the elements.
  #
  # data - A Hash containg the data for each association that needs to be built.
  #
  # Returns Nothing.
  def build_children_with data
    associations[:children].each do |child|
      klass_name = get_klass_name(child).constantize
      _data      = *data[child]
      built_objs = []

      _data.each do |element|
         built_objs << klass_name.build(element)
      end
      __set_belongs_to(built_objs) unless built_objs.last.associations[:parents].nil?

      # If we only have one item we extract it from the array
      built_objs = built_objs.first if built_objs.length == 1
      __set_meta_reader(child, built_objs)
    end
  end
  private :build_children_with

  # Internal: Build the associated class for each has_one association,
  # according to the data. Also defines a corresponding attr_reader to get the elements.
  #
  # data - A Hash containg the data for each association that needs to be built.
  #
  # Returns Nothing.
  def build_child_with data
    associations[:child].each do |child|
      klass_name = get_klass_name(child).constantize
      built_obj  = klass_name.build(data[child])

      __set_belongs_to(built_obj) unless built_obj.associations[:parents].nil?
      __set_meta_reader(child, built_obj)
    end
  end
  private :build_child_with

  # Internal: Build the associated belongs_to association for any has_many or has_one association
  #
  # objects - an Array of Objects implementing Facebook::Model, or a single Object.
  #
  # Returns the Objects.
  def __set_belongs_to objects
    objects = [objects] unless objects.kind_of? Array
    parents = []

    objects.last.associations[:parents].each do |parent|
      if self.class.inspect == get_klass_name(parent)
        parents << parent
      end
    end

    objects.each do |o|
      parents.each do |parent|
        o.send(:__set_meta_reader, parent, self)
      end
    end
    objects
  end
  private :__set_belongs_to

  # Internal: Defines an instance variable and the corresponding reader
  #
  # n - The name of the accessor
  # v - The value for the instance variable
  #
  # Returns Nothing.
  def __set_meta_reader(n, v)
    instance_variable_set("@#{n}", v)
    self.class.__send__(:attr_reader, "#{n}".to_sym)
  end
  private :__set_meta_reader
  # Internal: Get the real class name
  #
  # klass - The class as a String.
  # opts  - A Hash of options (default: { singularize: true }).
  #         :singularize - Wether the class name should be singular or not, as a Boolean.
  #
  # Returns a String.
  def get_klass_name klass, opts = { singularize: true }
    name = klass.to_s.classify
    name = name.singularize if opts[:singularize]
    "Facebook::#{name}"
  end
  private :get_klass_name

  class << self
    attr_reader :associations

    # Public: Needs to be implemented by all subclasses.
    # A correct implementation MUST return a new instance of the current class
    # provided with needed data.
    #
    # Example
    #
    #   class Facebook::Foo < Facebook::Model
    #     has_one :user
    #
    #     def self.build
    #       self.new(user: { name: 'Marc' })
    #     end
    #   end
    #
    # Returns Nothing.
    # Raises NotImplementedError if the subclass doesn't implement it.
    def build
      raise NotImplementedError.new("A class level method build needs to be implemented. It MUST return a new instance of this class by calling new and passing it data for it's associations.")
    end

    # Public: Defines an association between the current class and a parent.
    # During the class instanciation, it will build the corresponding class
    # with the data provided.
    #
    # klass - The parent class.
    #
    # Examples
    #
    #   class MyClass < Facebook::Model; belongs_to :user end
    #   # Later, when instanciating
    #   MyClass.new(user: { name: 'Thomas' })
    #   # This will build Facebook::User with the given hash, by calling Facebook::User.build(hash)
    #
    # Returns Nothing.
    def belongs_to klass
      @associations ||= {}
      @associations[:parents] ||= []

      @associations[:parents] << klass
    end

    # Public: Defines an association between the current class and children.
    # During the class instanciation, it will build the corresponding class
    # with the data provided.
    #
    # klass - The children class.
    #
    # Examples
    #
    #   class MyClass < Facebook::Model; has_many :users end
    #   # Later, when instanciating
    #   MyClass.new(users: [{ name: 'Thomas' }, { name: 'Yann' }])
    #   # This will build Facebook::User with the given hash, by calling Facebook::User.build(hash)
    #
    # Returns Nothing.
    def has_many klass
      @associations ||= {}
      @associations[:children] ||= []

      @associations[:children] << klass
    end

    # Public: Defines an association between the current class and a child.
    # During the class instanciation, it will build the corresponding class
    # with the data provided.
    #
    # klass - The child class.
    #
    # Examples
    #
    #   class MyClass < Facebook::Model; has_one :user end
    #   # Later, when instanciating
    #   MyClass.new(user: { name: 'Thomas' })
    #   # This will build Facebook::User with the given hash, by calling Facebook::User.build(hash)
    #
    # Returns Nothing.
    def has_one klass
      @associations ||= {}
      @associations[:child] ||= []

      @associations[:child] << klass
    end

    # Internal: Accessor for associations
    #
    # Returns an Hash of Arrays.
    def associations
      @associations
    end
  end
end
