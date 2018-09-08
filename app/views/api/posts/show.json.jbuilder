json.links do
  json.self api_rooster_cluck_url(@post.user.id, @post.id)
  json.list api_rooster_clucks_url(@post.user.id)
  json.delete do
    json.method "DELETE"
    json.href api_rooster_cluck_url(@post.user.id, @post.id)
  end
end
json.data do
  json.user_id @post.user_id
  json.username @post.user.username
  json.attributes do
    json.id @post.id
    json.body @post.body
    json.favorites_count @post.favorites.count
  end
end