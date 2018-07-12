require 'test_helper'

class PageControllerTest < ActionDispatch::IntegrationTest
  test "should get contact_us" do
    get page_contact_us_url
    assert_response :success
  end

  test "should get products" do
    get page_products_url
    assert_response :success
  end

  test "should get preferences_old" do
    get page_preferences_url
    assert_response :success
  end

  test "should get blog" do
    get page_blog_url
    assert_response :success
  end

  test "should get calendar" do
    get page_calendar_url
    assert_response :success
  end

  test "should get articles" do
    get page_articles_url
    assert_response :success
  end

  test "should get login_old" do
    get page_login_url
    assert_response :success
  end

end
