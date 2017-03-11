FactoryGirl.define do
  factory :user do
    name "John Smith"
    email { "#{name.gsub(/ /,'').downcase}@example.com" }
    password "password"
    password_confirmation "password"
    #confirmed_at Time.now
  end
end
