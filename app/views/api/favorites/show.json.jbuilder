json.data do
  json.type "favorites"
  json.id @favorite.id
  json.attributes do
    json.user_id @favorite.user_id
    json.username User.find(@favorite.user_id).username
  end
  json.relationships do
    json.post do
      json.data do
        json.id @favorite.post_id
        json.body @favorite.post.body
      end
      json.links do
        json.self api_user_path(@user)
      end
    end
  end
  json.links do
    json.self api_user_post_favorites_path(@favorite.post.user, @favorite.post_id)
    json.list api_user_post_favorites_path
    json.delete do
      json.method "DELETE"
      json.href api_user_post_favorites_path(@favorite.post.user, @favorite.post_id)
    end
  end
end
