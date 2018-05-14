require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'that you cannot save blank users' do
    user = User.new
    assert_not user.save
  end

  test 'that passwords must be atleast 6 characters long' do
    user = User.new(email: 'test@testing.com', password: '12345')

    assert_not user.save
  end

  test 'that emails are unique' do
    params = { email: 'pesho@abv.bg', password: 'random' }
    User.create(params)

    assert_not User.create(params)
  end
end
