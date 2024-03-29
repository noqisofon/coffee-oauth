utils = require './extern/utils'
Module = require './extern/module'

OAuth = {} unless OAuth?

OAuth.Helper = require './helper'


class OAuth.Token extends Module
    @include OAuth.Helper

    constructor: (@_token, @_secret) ->

    @getter 'secret', -> @_secret

    @getter 'token', -> @_token

    toQuery: -> "oauth_token=#{this.escape( @_token )}&oauth_secret=#{escape( @_secret )}"


exports = OAuth.Token
module.exports = OAuth.Token
