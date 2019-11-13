require "application_system_test_case"

class WsersTest < ApplicationSystemTestCase
  setup do
    @wser = wsers(:one)
  end

  test "visiting the index" do
    visit wsers_url
    assert_selector "h1", text: "Wsers"
  end

  test "creating a Wser" do
    visit wsers_url
    click_on "New Wser"

    fill_in "Name", with: @wser.name
    fill_in "Password", with: 'secret'
    fill_in "Password confirmation", with: 'secret'
    click_on "Create Wser"

    assert_text "Wser was successfully created"
    click_on "Back"
  end

  test "updating a Wser" do
    visit wsers_url
    click_on "Edit", match: :first

    fill_in "Name", with: @wser.name
    fill_in "Password", with: 'secret'
    fill_in "Password confirmation", with: 'secret'
    click_on "Update Wser"

    assert_text "Wser was successfully updated"
    click_on "Back"
  end

  test "destroying a Wser" do
    visit wsers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wser was successfully destroyed"
  end
end
