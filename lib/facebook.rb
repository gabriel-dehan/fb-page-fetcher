module Facebook
  @@token = nil

  class << self
    # Public: Retrives an instance of Koala::Facebook::API and caches it.
    #
    # Returns an instance of Koala::Facebook::API.
    def connect
      @@connection ||= Koala::Facebook::API.new(token)
    end

    private
      # Internal: Get a token and caches it.
      #
      # Returns the token as a String.
      def token
        return @@token unless @@token.nil?

        app_id     = '328272323953251'
        app_secret = '5c6f7a79e46beb102978501b054f5ee6'
        token      = 'AAAEqj9tCQmMBANzk8PZCZAOaKzzZBO0uwFgCJY8F1HU2Vqsjmu4fAslrlEluEJaZCKaaaYBvHvezPtJz2vXdU9YTaVRWSZA8dFZBVaQtHU3AZDZD'
        oauth = Koala::Facebook::OAuth.new(app_id, app_secret)
        @@token = oauth.exchange_access_token(token)
      end
  end
end
