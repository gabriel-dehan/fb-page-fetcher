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
        token     = 'AAAEqj9tCQmMBAJ87aG94LAj8YsZBtwI1qgZBAUsuesZB3ImZAiksMwYqfcNzBdAgWd0fXd9omZC5UQZBNw1wsOH2G3gERw0qZBhARcOPVkdpQZDZD'
        @@token = token
#       oauth = Koala::Facebook::OAuth.new(app_id, app_secret)
#       @@token = oauth.exchange_access_token(token)
      end
  end
end
