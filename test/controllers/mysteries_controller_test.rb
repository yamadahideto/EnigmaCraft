require "test_helper"

class MysteriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mysteries_index_url
    assert_response :success
  end

  test "should get show" do
    get mysteries_show_url
    assert_response :success
  end

  test "should get new" do
    get mysteries_new_url
    assert_response :success
  end

  test "should get create" do
    get mysteries_create_url
    assert_response :success
  end

  test "should get edit" do
    get mysteries_edit_url
    assert_response :success
  end

  test "should get update" do
    get mysteries_update_url
    assert_response :success
  end

  test "should get destroy" do
    get mysteries_destroy_url
    assert_response :success
  end
end
