utils = require './extern/utils'
Module = require './extern/module'

OAuth = exports? and exports or @OAuth = {}

OAuth.Helper = require './helper'


class OAuth.Token extends Module
    @include OAuth.Helper

    constructor: (token, secret) ->
        @_token = token
        @_secret = secret

    @getter 'secret', -> @_secret

    @getter 'token', -> @_token

    toQuery: -> "oauth_token=#{this.escape( @_token )}&oauth_secret=#{escape( @_secret )}"


exports.Token = OAuth.Token
module.exports.Token = OAuth.Token
