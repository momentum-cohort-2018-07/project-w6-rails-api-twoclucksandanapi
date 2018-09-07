
json.data do
  json.type "followers"
  json.id @follower.id
  json.attributes do
    json.user_id @follower.follower_id
    json.username User.find(@follower.follower_id).username
  end
  json.relationships do
    json.user do
      json.data do
        json.id @user.id
        json.username @user.username
      end
      json.links do
          json.self api_user_path(@user)
      end
    end
  end
  json.links do
    json.self api_user_follower_path(@user, @follower.follower_id)
    json.list api_user_followers_path
    json.update do
      json.method "PUT"
      json.href api_user_follower_path(@user, @follower.follower_id)
    end
    json.delete do
      json.method "DELETE"
      json.href api_user_follower_path(@user, @follower.follower_id)
    end
  end
end
