require 'twitter'
require 'tweetstream'
require 'mysql2'
require 'json'

# Connect to the Streaming API
TweetStream.configure do |config|
	config.consumer_key       = '0iGriIYgWLiQThhbuEPKbmgYV'
	config.consumer_secret    = 'EUxLYgrsRcdykkpyRhZrt5ViTMO7e9in33CxODxyQBtuVdx3cg'
	config.oauth_token        = '3541214658-DEjwOv00F829Qa9Srndq5ri8MnCXxfiGccwYa1W'
	config.oauth_token_secret = 'PTg5WegA7ohvLZRfucqMK59r1NggcSPAgAIfjIQa6YuuI'
	config.auth_method        = :oauth
end

# Connect to the REST API
client = Twitter::REST::Client.new do |config|
	config.consumer_key        = "0iGriIYgWLiQThhbuEPKbmgYV"
	config.consumer_secret     = "EUxLYgrsRcdykkpyRhZrt5ViTMO7e9in33CxODxyQBtuVdx3cg"
	config.access_token        = "3541214658-DEjwOv00F829Qa9Srndq5ri8MnCXxfiGccwYa1W"
	config.access_token_secret = "PTg5WegA7ohvLZRfucqMK59r1NggcSPAgAIfjIQa6YuuI"
end

# Connect to the MySQL Database
# Host Name, User, Pass
con = Mysql2::Client.new(:host => "localhost", :username => "twitter_user", 
	:password => "twitter", :database => "twitter_test")

# Stream terms
TweetStream::Client.new.track('trump', 'Trump', 'Donald Trump') do |status|
	puts "#{status.text}"

	# Save User
	sql = "INSERT INTO users(user_id, screen_name) VALUES(?, ?)"
	st = con.prepare(sql)
	st.execute(status.user.id, status.user.screen_name)

	results = con.query("SELECT LAST_INSERT_ID()")
	user_id = results.first["LAST_INSERT_ID()"]

	# Save Tweet
	sql = "INSERT INTO tweets(user_id, text) VALUES(?, ?)"
	st = con.prepare(sql)
	st.execute(user_id, status.text)
end