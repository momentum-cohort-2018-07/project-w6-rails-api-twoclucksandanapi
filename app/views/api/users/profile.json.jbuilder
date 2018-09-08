json.links do
  json.self api_rooster_url(@user)
  json.list api_roosters_url
  json.update do
    json.method "PUT"
    json.href api_rooster_url(@user)
  end
  json.delete do
    json.method "DELETE"
    json.href api_rooster_url(@user)
  end
end
json.data do
  json.id @user.id
  json.attributes do
    json.username @user.username
    json.api_token @user.api_token
    json.post @user.posts.count
    json.followers @user.followers.count
  end
end