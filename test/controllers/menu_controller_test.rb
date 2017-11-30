require 'test_helper'

class MenuControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get menu_index_url
    assert_response :success
  end

  test "should get new" do
    get menu_new_url
    assert_response :success
  end

  test "should get create" do
    get menu_create_url
    assert_response :success
  end

  test "should get listing" do
    get menu_listing_url
    assert_response :success
  end

  test "should get pricing" do
    get menu_pricing_url
    assert_response :success
  end

  test "should get description" do
    get menu_description_url
    assert_response :success
  end

  test "should get photo_upload" do
    get menu_photo_upload_url
    assert_response :success
  end

  test "should get amenities" do
    get menu_amenities_url
    assert_response :success
  end

  test "should get location" do
    get menu_location_url
    assert_response :success
  end

  test "should get update" do
    get menu_update_url
    assert_response :success
  end

end
