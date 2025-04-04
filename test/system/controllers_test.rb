require "application_system_test_case"

class ControllersTest < ApplicationSystemTestCase
  setup do
    @controller = controllers(:one)
  end

  test "visiting the index" do
    visit controllers_url
    assert_selector "h1", text: "Controllers"
  end

  test "should create controller" do
    visit controllers_url
    click_on "New controller"

    fill_in "Posts", with: @controller.posts
    click_on "Create Controller"

    assert_text "Controller was successfully created"
    click_on "Back"
  end

  test "should update Controller" do
    visit controller_url(@controller)
    click_on "Edit this controller", match: :first

    fill_in "Posts", with: @controller.posts
    click_on "Update Controller"

    assert_text "Controller was successfully updated"
    click_on "Back"
  end

  test "should destroy Controller" do
    visit controller_url(@controller)
    click_on "Destroy this controller", match: :first

    assert_text "Controller was successfully destroyed"
  end
end
