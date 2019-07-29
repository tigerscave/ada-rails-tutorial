json.array! @users do |user|
  json.id user.id
  json.name user.name
  json.created_at user.created_at
  json.first_micropost user.microposts.first
end