json.friends do
  json.partial! "api/v1/friendships/friend", collection: @friends, as: :friend
end
