Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], {
    :access_type => 'online',
    :prompt => ''
  }
  provider :dropbox_oauth2, ENV['DROPBOX_APP_KEY'], ENV['DROPBOX_APP_SECRET']
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
end
