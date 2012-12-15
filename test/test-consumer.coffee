OAuth = require 'oauth'


consumer = new OAuth.Consumer
    key: "YOUR CONSUMER KEY"
    secret: "YOUR CONSUMER SECRET"
    site: "http://api.twitter.com"


request_token = consumer.getRequestToken()
