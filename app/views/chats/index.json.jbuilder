json.array!(@chats) do |chat|
  json.extract! chat, :id, :user_id, :message
  json.url chat_url(chat, format: :json)
end
