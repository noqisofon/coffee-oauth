utils = require './extern/utils'
Module = require './extern/module'

OAuth = exports? and exports or @OAuth = {}

OAuth.AccessToken = require './access_token'
OAuth.ConsumerToken = require './consumer_token'


class OAuth.RequestToken extends OAuth.ConsumerToken

    getAuthorizeURL: (params = null) ->
        params = ( params or {} ).merge { oauth_token: @token }
        buildAuthorizeURL this.consumer.getAuthorizeURL(), params

    isCallbackConfirmed: ->
        this.params["oauth_callback_confirmed"] = "true"
        true

    getAccessToken: (options = {}, args...) ->
        if this.consumer.isAccessTokenURL()
            access_token_url = this.consumer.getAccessTokenURL()
        else
            access_token_url = this.consumer.getAccessTokenPath()

        response = this.customer.tokenRequest this.consumer.getHttpMethod(), access_token_url, this, options, args
        OAuth.AccessToken.fromHash this.consumer, response


exports = OAuth.RequestToken
module.exports = OAuth.RequestToken
