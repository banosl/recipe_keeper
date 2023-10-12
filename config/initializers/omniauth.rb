Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
  redirect_uri: "https://localhost:3000/auth/google_oauth2/callback"
  # redirect_uri: "https://recipe-keeper-2jsm.onrender.com/auth/google_oauth2/callback"
end
OmniAuth.config.allowed_request_methods = %i[post]