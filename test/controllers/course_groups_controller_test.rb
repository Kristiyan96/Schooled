require 'test_helper'

class CourseGroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get course_groups_show_url
    assert_response :success
  end

end
