json.partial! "user", user: @user
json.token @user.token
json.email @user.email
json.last_known_location @user.last_known_location
json.city_id @user.city_id
json.is_seller @user.is_seller
json.bgcheck_verified @user.bgcheck_verified
json.facebook_user_token @user.facebook_user_token
json.bgcheck_approved @user.bgcheck_approved
json.referral_code User.referral_code(@user.id)
