json.extract! message, :id, :chat_room_id, :content, :created_at, :updated_at
json.url message_url(message, format: :json)
