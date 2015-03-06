require 'test_helper'

class ChatsControllerTest < ActionController::TestCase
  setup do
    @chat = chats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chat" do
    assert_difference('Chat.count') do
      post :create, chat: { message: @chat.message, user_id: @chat.user_id }
    end

    assert_redirected_to chat_path(assigns(:chat))
  end

  test "should show chat" do
    get :show, id: @chat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chat
    assert_response :success
  end

  test "should update chat" do
    patch :update, id: @chat, chat: { message: @chat.message, user_id: @chat.user_id }
    assert_redirected_to chat_path(assigns(:chat))
  end

  test "should destroy chat" do
    assert_difference('Chat.count', -1) do
      delete :destroy, id: @chat
    end

    assert_redirected_to chats_path
  end
end
