require './test/test_helper.rb'

class RegisterUserTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy #may change this name later - SP
  end

  def test_new_user_can_register
    post '/sources' { client: { data_identifier: "example", root_url: "HTTP://Example.com"}}

    assert_equal 1, Source.count
    assert_equal 200, last_response.status
    assert_equal "Success - 200 OK", last_response.body
  end

  def test_unregistered_user_receives_error_when_id_missing
    post '/sources' { client: { root_url: "HTTP://Example.com"}}

    assert_equal 0, Source.count
    assert_equal 400, last_response.status
    assert_equal "Missing Params 400 - Bad Request", last_response.body

  end

  def test_unregistered_user_receives_error_when_url_missing
    post '/sources' { client: { data_identifier: "example"}}

    assert_equal 0, Source.count
    assert_equal 400, last_response.status
    assert_equal "Missing Params 400 - Bad Request", last_response.body
  end

  def test_unregistered_user_receives_error_when_id_and_url_missing
    post '/sources' { client: { }}

    assert_equal 0, Source.count
    assert_equal 400, last_response.status
    assert_equal "Missing Params 400 - Bad Request", last_response.body
  end

  def test_registered_user_receives_error_when_registering
    # create a user with the data_id "example" and root_url "http://example.com"
    assert_equal 1, Source.count
    post '/sources' { client: { data_identifier: "example", root_url: "HTTP://Example.com"}}

    assert_equal 1, Source.count
    assert_equal 403, last_response.status
    assert_equal "User already exists 403 - Bad Request", last_response.body

  end



end