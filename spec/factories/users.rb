FactoryGirl.define do
  factory :user do
    name 'Example User'
    email 'user@example.com'
    password 'foobar'
    password_digest "#{User.digest('foobar')}"
  end
end
