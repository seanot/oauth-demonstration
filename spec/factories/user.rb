FactoryGirl.define do
  factory :user do |f|
    f.provider 'google_oauth2'
    f.email 'sean@seanco.com'
    f.uid 12345
    f.name 'Sean'
    f.oauth_token 'thisisanoauthtoken888'
    f.oauth_expires_at nil
  end
end