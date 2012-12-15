utils = require './extern/utils'
Module = require './extern/module'

OAuth = {} unless OAuth?

OAuth.ConsumerToken = require './consumer_token'


class OAuth.AccessToken extends OAuth.ConsumerToken
    constructor: (consumer, token = "", secret = "") ->
        super token, secret
        @_consumer = consumer
        @_params = {}


exports = OAuth.AccessToken
module.exports = OAuth.AccessToken
