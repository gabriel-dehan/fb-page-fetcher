module Facebook
  def self.connect
    @@connection ||= Koala::Facebook::API.new('AAACEdEose0cBAPU7VwPoz4qmRpvgYT7FZCfmcQPbK1J0yuBzB4mnH6AvoOKtKLFAbfDcJLOFOqjqKw5WG5MbtLwEApqP1iKmVjWtxRgZDZD')
  end
end
