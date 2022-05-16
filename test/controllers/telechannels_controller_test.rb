require "test_helper"

class TelechannelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @telechannel = telechannels(:one)
  end

  test "should get index" do
    get telechannels_url
    assert_response :success
  end

  test "should get new" do
    get new_telechannel_url
    assert_response :success
  end

  test "should create telechannel" do
    assert_difference('Telechannel.count') do
      post telechannels_url, params: { telechannel: { content: @telechannel.content, image: @telechannel.image, name: @telechannel.name } }
    end

    assert_redirected_to telechannel_url(Telechannel.last)
  end

  test "should show telechannel" do
    get telechannel_url(@telechannel)
    assert_response :success
  end

  test "should get edit" do
    get edit_telechannel_url(@telechannel)
    assert_response :success
  end

  test "should update telechannel" do
    patch telechannel_url(@telechannel), params: { telechannel: { content: @telechannel.content, image: @telechannel.image, name: @telechannel.name } }
    assert_redirected_to telechannel_url(@telechannel)
  end

  test "should destroy telechannel" do
    assert_difference('Telechannel.count', -1) do
      delete telechannel_url(@telechannel)
    end

    assert_redirected_to telechannels_url
  end
end
