require 'test_helper'

class CalendarsControllerTest < ActionController::TestCase
  setup do
    @calendar = calendars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calendars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create calendar" do
    assert_difference('Calendar.count') do
      post :create, calendar: { access_token: @calendar.access_token, client_id: @calendar.client_id, client_secret: @calendar.client_secret, code: @calendar.code, redirect_uri: @calendar.redirect_uri, refresh_token: @calendar.refresh_token }
    end

    assert_redirected_to calendar_path(assigns(:calendar))
  end

  test "should show calendar" do
    get :show, id: @calendar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @calendar
    assert_response :success
  end

  test "should update calendar" do
    put :update, id: @calendar, calendar: { access_token: @calendar.access_token, client_id: @calendar.client_id, client_secret: @calendar.client_secret, code: @calendar.code, redirect_uri: @calendar.redirect_uri, refresh_token: @calendar.refresh_token }
    assert_redirected_to calendar_path(assigns(:calendar))
  end

  test "should destroy calendar" do
    assert_difference('Calendar.count', -1) do
      delete :destroy, id: @calendar
    end

    assert_redirected_to calendars_path
  end
end
