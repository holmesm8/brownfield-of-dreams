Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
  provider :github, ENV['CLIENT_ID_KEY'], ENV['CLIENT_SECRET_KEY'], scope: "user,repo"
end
