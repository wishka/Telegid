require "application_system_test_case"

class TelechannelsTest < ApplicationSystemTestCase
  setup do
    @telechannel = telechannels(:one)
  end

  test "visiting the index" do
    visit telechannels_url
    assert_selector "h1", text: "Telechannels"
  end

  test "creating a Telechannel" do
    visit telechannels_url
    click_on "New Telechannel"

    fill_in "Content", with: @telechannel.content
    fill_in "Image", with: @telechannel.image
    fill_in "Name", with: @telechannel.name
    click_on "Create Telechannel"

    assert_text "Telechannel was successfully created"
    click_on "Back"
  end

  test "updating a Telechannel" do
    visit telechannels_url
    click_on "Edit", match: :first

    fill_in "Content", with: @telechannel.content
    fill_in "Image", with: @telechannel.image
    fill_in "Name", with: @telechannel.name
    click_on "Update Telechannel"

    assert_text "Telechannel was successfully updated"
    click_on "Back"
  end

  test "destroying a Telechannel" do
    visit telechannels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Telechannel was successfully destroyed"
  end
end
