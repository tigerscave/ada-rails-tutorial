json.array! @microposts do |micropost|
  json.id micropost.id
  json.name micropost.content
  json.created_at micropost.created_at
end