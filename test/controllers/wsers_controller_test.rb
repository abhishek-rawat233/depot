require 'test_helper'

class WsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wser = wsers(:one)
  end

  test "should get index" do
    get wsers_url
    assert_response :success
  end

  test "should get new" do
    get new_wser_url
    assert_response :success
  end

  test "should create wser" do
    assert_difference('Wser.count') do
      post wsers_url, params: { wser: { name: @wser.name, password: 'secret', password_confirmation: 'secret' } }
    end

    assert_redirected_to wser_url(Wser.last)
  end

  test "should show wser" do
    get wser_url(@wser)
    assert_response :success
  end

  test "should get edit" do
    get edit_wser_url(@wser)
    assert_response :success
  end

  test "should update wser" do
    patch wser_url(@wser), params: { wser: { name: @wser.name, password: 'secret', password_confirmation: 'secret' } }
    assert_redirected_to wser_url(@wser)
  end

  test "should destroy wser" do
    assert_difference('Wser.count', -1) do
      delete wser_url(@wser)
    end

    assert_redirected_to wsers_url
  end
end
