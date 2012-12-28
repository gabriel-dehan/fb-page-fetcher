module Facebook
  def self.connect
    @@connection ||= Koala::Facebook::API.new('AAACEdEose0cBAG0OQTmuZAb5oCtT9hM4HXpwM8qXfED9hhBivcgudqazd4n1BAsUEXHZCEu4IKYeX2ei9ktmZApdfLOpJOyB9YlNfiwIAZDZD')
  end
end
