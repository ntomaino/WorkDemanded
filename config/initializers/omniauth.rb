Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, ENV['298414583617910'], ENV['7d9dfd2f4b127bb8d8c75f705124ebc8']

end
  