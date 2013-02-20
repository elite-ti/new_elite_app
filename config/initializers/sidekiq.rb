server = 'localhost' 
port = 6379

Sidekiq.configure_server do |config|  
  config.redis = { url: "redis://#{server}:#{port}/0" }
end