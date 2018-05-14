require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'you can get to the login page' do
    get login_path
    assert_response :success
  end

  test 'you can login with a new user' do
    pesho = User.create(email: 'pesho@abv.bg', password: '123123')

    get '/login'
    assert_equal 200, status

    post '/sessions', params: {
      sessions: {
        email: pesho.email,
        password: pesho.password
      }
    }

    follow_redirect!
    assert_equal 200, status
    assert response.body.include? pesho.email
  end
end
