json.array!(@blogs) do |blog|
  json.extract! blog, :id, :title, :user_id, :body
  json.url blog_url(blog, format: :json)
end
