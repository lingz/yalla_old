require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get faq" do
    get :faq
    assert_response :success
  end

end
