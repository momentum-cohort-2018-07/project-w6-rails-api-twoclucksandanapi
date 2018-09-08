json.array! @followers do |follower|
  json.attributes do
    json.user_id follower.user_id
    json.username User.find(follower.user_id).username
  end
  json.links do
    json.self api_user_follows_path(follower.follower_id)
    json.user api_user_path(follower.user_id)
  end
end