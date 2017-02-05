require 'test_helper'

class GetLibraryTest < ActionDispatch::IntegrationTest
  test 'returns a list of all library entries' do     
    get '/entries'
    assert_equal 200, response.status
    refute_empty response.body
  end
end
