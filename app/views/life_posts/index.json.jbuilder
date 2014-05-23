json.array!(@life_posts) do |life_post|
  json.extract! life_post, :id, :title
  json.url life_post_url(life_post, format: :json)
end
