fb-page-fetcher
===============

Rails Exercise using the facebook open graph api.

Goals : 
* Get a facebook page and display it's feed.

Technical goals :
* 100% code coverage (simplecov) (apart from mocked objects and APIs)
* Try using minitest instead of rspec
* Use backbone js to handle the client side model loading/rendering
* Create a facebook model class that emulates activerecord::relations behavior, but with facebook data, on the fly

Run the tests : `rake minitest`

Run models tests : `rake minitest:models`

Run integration tests : `rake minitest:integration`

Run facebook module tests : `ruby -Itest test/models/facebook_test.rb` (Better off testing it without rake, it is much much faster)

