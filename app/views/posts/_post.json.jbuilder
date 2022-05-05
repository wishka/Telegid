json.extract! post, :id, :title, :content, :customer_id, :room_id, :created_at, :updated_at
json.url post_url(post, format: :json)
