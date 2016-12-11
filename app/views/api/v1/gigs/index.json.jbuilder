json.(@gigs) do |gig|
  json.id gig.id
  json.title gig.title
  json.description gig.description
  json.price gig.price
  json.user_id gig.user_id
  json.is_active gig.is_active
  json.is_featured gig.featured
  json.token gig.token
  json.status gig.status
  json.likes @likes[gig.id]
  json.is_liked @is_liked[gig.id]
  json.category @category[gig.id]
  json.is_bookmarked @is_bookmarked[gig.id]
end
