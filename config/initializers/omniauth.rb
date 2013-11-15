Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_KEY"], ENV["GOOGLE_SECRET"]
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :dropbox_oauth2, ENV['DROPBOX_APP_KEY'], ENV['DROPBOX_APP_SECRET']
end