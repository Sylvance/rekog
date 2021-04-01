require "test_helper"

class ImageQueriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image_query = image_queries(:one)
  end

  test "should get index" do
    get image_queries_url
    assert_response :success
  end

  test "should get new" do
    get new_image_query_url
    assert_response :success
  end

  test "should create image_query" do
    assert_difference('ImageQuery.count') do
      post image_queries_url, params: { image_query: { is_match: @image_query.is_match, name: @image_query.name, percentage_match: @image_query.percentage_match, person_id: @image_query.person_id } }
    end

    assert_redirected_to image_query_url(ImageQuery.last)
  end

  test "should show image_query" do
    get image_query_url(@image_query)
    assert_response :success
  end

  test "should get edit" do
    get edit_image_query_url(@image_query)
    assert_response :success
  end

  test "should update image_query" do
    patch image_query_url(@image_query), params: { image_query: { is_match: @image_query.is_match, name: @image_query.name, percentage_match: @image_query.percentage_match, person_id: @image_query.person_id } }
    assert_redirected_to image_query_url(@image_query)
  end

  test "should destroy image_query" do
    assert_difference('ImageQuery.count', -1) do
      delete image_query_url(@image_query)
    end

    assert_redirected_to image_queries_url
  end
end
