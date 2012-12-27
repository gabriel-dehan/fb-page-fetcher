module Facebook
  def self.connect
    @@connection ||= Koala::Facebook::API.new('AAACEdEose0cBANMrRh7tB8i5UVdRDcMzk8yQZAGbXIgxIZCK9lFEAIbiHGE8et5FbbGnbXQZAiW6mlVT9ttCZAjZBe2CoBzZAXjqcMBExcnQZDZD')
  end
end
