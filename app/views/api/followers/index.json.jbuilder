json.array! @followers do |follower|
  json.attributes do
    json.user_id follower.follower_id
    json.username User.find(follower.follower_id).username
  end
  json.links do
    json.self api_user_follower_path(follower.user, follower.follower_id)
    json.user api_user_path(follower.follower_id)
  end
end