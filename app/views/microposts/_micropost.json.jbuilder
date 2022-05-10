json.extract! micropost, :id, :title, :content, :image, :created_at, :updated_at
json.url micropost_url(micropost, format: :json)
