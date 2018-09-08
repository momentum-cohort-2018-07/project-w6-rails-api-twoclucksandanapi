json.data do
  json.type "posts"
  json.id post.id
  json.attributes do
    json.user_id post.user_id
    json.body post.body
    json.posted_at post.created_at
  end
  json.relationships do
    json.user do
      json.data do
        json.id post.user.id
        json.username post.user.username
      end
      json.links do
          json.self api_rooster_path(post.user)
      end
    end
  end
  json.links do
    json.self api_rooster_cluck_url(post.user, post)
    json.list api_rooster_clucks_url(post.user)
    json.delete do
      json.method "DELETE"
      json.href api_rooster_cluck_url(post.user, post)
    end
  end
end
