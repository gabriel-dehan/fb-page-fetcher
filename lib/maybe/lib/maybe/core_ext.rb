require_relative '../maybe'

class Object
  def maybe
    Maybe.new(self)
  end
end
