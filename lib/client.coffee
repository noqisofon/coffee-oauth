utils = require './extern/utils'
Module = require './extern/module'
URI = require './extern/uri'
Net = require './extern/net/http'

OAuth = require './oauth'
OAuth.Helper = require './helper'


class OAuth.Client
    class Helper extends Module
        @include OAuth.Helper

        constructor: (request, options = {}) ->
            @_request = request
            @_options = options

            @_options['signature_method'] or= 'HMAC-SHA1'

        amendUserAgentHeader: (headers) ->
            @_oauth_ua_string or= "coffee-oauth v#{OAuth.VERSION}"

            if headers['User-Agent'] and not headers['User-Agent'] == 'JS'
                headers['User-Agent'] += " (#{@_oauth_ua_string})"
            else
                headers['User-Agent'] = @_oauth_ua_string

        getHashBody: ->
            @_options['body_hash'] = OAuth.Signature.getBodyHash @_request, { parameters: this.getOAuthParameters() }

        getHeader: ->
            parameters = this.getOAuthParameters()
            parameters = parameters.merge
                oauth_signature: this.signature @_options.merge
                    parameter: parameters

        nonce: ->
            @_options['nonce'] or= this.generateKey()

        getOAuthParameters: ->
            

exports = OAuth.Client
module.exports = OAuth.Client
