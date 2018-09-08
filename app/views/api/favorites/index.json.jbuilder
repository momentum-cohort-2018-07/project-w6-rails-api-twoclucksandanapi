json.array! @favorites do |favorite|
  json.attributes do
    json.user_id favorite.user_id
    json.username User.find(favorite.user_id).username
  end
  json.links do
    json.self api_user_post_favorites_path(favorite.post.user, favorite.post_id)
    json.user api_user_path(favorite.user_id)
  end
end