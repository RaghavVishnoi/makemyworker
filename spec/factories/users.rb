FactoryGirl.define do
  sequence(:facebook_id) { |n| "#{n}1004453333331" }
  sequence(:facebook_user_token) { |n| "#{n}CAA" + ("X" * 216) }

  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    email {Faker::Internet.email}
    facebook_user_id { generate(:facebook_id) }
    facebook_user_token

    birthday { Date.current }
    gender "male"

    token { Token.new.generate }
  end

end
