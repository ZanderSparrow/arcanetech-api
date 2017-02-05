require 'test_helper'

class GetLibraryTest < ActionDispatch::IntegrationTest
  test 'returns a list of all library entries' do     
    get '/entries'
    assert_equal 200, response.status
    refute_empty response.body
  end

  test 'filters entries by title' do
    entry1 = Entry.create!(title: 'Moth', description: 'An insect that can disrupt light-base force fields.')
    entry2 = Entry.create!(title: 'Herring Thread', description: 'Fish bones used as a conductor.')

    get '/entries?title=Moth'
    assert_equal 200, response.status

    entries = JSON.parse(response.body, symbolize_names: true)
    titles = entries.collect { |e| e[:title] }
    assert_includes titles, 'Moth'
    refute_includes titles, 'Herring Thread'
  end
end
