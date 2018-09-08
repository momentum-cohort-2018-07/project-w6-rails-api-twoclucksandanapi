json.links do
  json.self api_rooster_url(user)
end
json.data do
  json.id user.id
  json.attributes do
    json.username user.username
    json.post user.posts.count
    json.followers user.followers.count
  end
  json.relationships do
    json.clucks do
      json.array! user.posts do |post|
        json.data post, :id, :body
        json.links do
          json.self api_rooster_cluck_path(user, post)
        end
      end
    end
  end
end