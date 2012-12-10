utils = require 'utils'
Module = require 'module'

OAuth = exports? and exports or @OAuth = {}

OAuth.Token = require 'token'


class OAuth.ConsumerToken extends OAuth.Token
    @fromHash: (consumer, hash) ->
        token = new ConsumerToken( consumer, hash["oauth_token"], hash["oauth_token_secret"] )
        token.params = hash
        token

    constructor: (consumer, token = "", secret = "") ->
        super token, secret
        @_consumer = consumer
        @_params = {}

    @attribute 'consumer',
        get: -> @_consumer
        set: (value) -> @_consumer = value

    @attribute 'params',
        get: -> @_params
        set: (value) -> @_params = value

    @getter 'response', -> @_response

    request: (http_method, path, args...) ->
        @_response = @_consumer.request( http_method, path, this, {}, args )

    sign: (request, options = {}) ->
        @_consumer.sign request, self, options

exports.OAuth.ConsumerToken = OAuth.ConsumerToken
