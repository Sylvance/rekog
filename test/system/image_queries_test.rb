require "application_system_test_case"

class ImageQueriesTest < ApplicationSystemTestCase
  setup do
    @image_query = image_queries(:one)
  end

  test "visiting the index" do
    visit image_queries_url
    assert_selector "h1", text: "Image Queries"
  end

  test "creating a Image query" do
    visit image_queries_url
    click_on "New Image Query"

    check "Is match" if @image_query.is_match
    fill_in "Name", with: @image_query.name
    fill_in "Percentage match", with: @image_query.percentage_match
    fill_in "Person", with: @image_query.person_id
    click_on "Create Image query"

    assert_text "Image query was successfully created"
    click_on "Back"
  end

  test "updating a Image query" do
    visit image_queries_url
    click_on "Edit", match: :first

    check "Is match" if @image_query.is_match
    fill_in "Name", with: @image_query.name
    fill_in "Percentage match", with: @image_query.percentage_match
    fill_in "Person", with: @image_query.person_id
    click_on "Update Image query"

    assert_text "Image query was successfully updated"
    click_on "Back"
  end

  test "destroying a Image query" do
    visit image_queries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Image query was successfully destroyed"
  end
end
