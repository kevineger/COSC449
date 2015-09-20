require 'twitter'
require 'tweetstream'

# Connect to the REST API
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "0iGriIYgWLiQThhbuEPKbmgYV"
  config.consumer_secret     = "EUxLYgrsRcdykkpyRhZrt5ViTMO7e9in33CxODxyQBtuVdx3cg"
  config.access_token        = "3541214658-DEjwOv00F829Qa9Srndq5ri8MnCXxfiGccwYa1W"
  config.access_token_secret = "PTg5WegA7ohvLZRfucqMK59r1NggcSPAgAIfjIQa6YuuI"
end

# Print each tweet in a user's timeline
timeline = client.user_timeline(213747670)
timeline.each do |t|
	puts t.text
end

# Search for the 3 most recent tweets
client.search("to:realDonaldTrump hate", result_type: "recent").take(3).collect do |tweet|
  puts "#{tweet.user.screen_name}: #{tweet.text}"
end

# Connect to the Streaming API
client = TweetStream.configure do |config|
	config.consumer_key       = '0iGriIYgWLiQThhbuEPKbmgYV'
	config.consumer_secret    = 'EUxLYgrsRcdykkpyRhZrt5ViTMO7e9in33CxODxyQBtuVdx3cg'
	config.oauth_token        = '3541214658-DEjwOv00F829Qa9Srndq5ri8MnCXxfiGccwYa1W'
	config.oauth_token_secret = 'PTg5WegA7ohvLZRfucqMK59r1NggcSPAgAIfjIQa6YuuI'
	config.auth_method        = :oauth
end

# Stream terms
TweetStream::Client.new.track('trump', 'Trump') do |status|
	puts "#{status.text}"
end