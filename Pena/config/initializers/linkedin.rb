LinkedIn.configure do |config|
  config.token = ENV['LINKEDIN_KEY']
  config.secret = ENV['LINKEDIN_SECRET']
end
