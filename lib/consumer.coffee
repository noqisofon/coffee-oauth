utils = require './extern/utils'
URI = require './extern/uri'
Net = require './extern/net/http'

OAuth = {} unless OAuth?

OAuth.AccessToken = require './access_token'
OAuth.RequestToken = require './request_token'
OAuth.Helper = require './helper'
OAuth.Problem = require './error/problem'
OAuth.Unathorized = require './error/unauthorized'


default_options =
    signature_method: "HMAC-SHA1"
    request_token_path: "/oauth/request_token"
    authorize_path: "/oauth/authorize"
    access_token_path: "/oauth/access_token"
    proxy: null
    scheme: "header"
    http_method: "post"
    oauth_version: "1.0"


merge = (me, another) ->
    opts = {}
    for key in me
        unless options[key]?
            opts[key] = me[key]
        else
            opts[key] = another[key]
    opts


createHttpRequest = (http_method, path, args...) ->
    if typeof args[args.length - 1] is 'function'
        #is_block_given = true
        block = args.pop()
    else
        #is_block_given = false
        block = null

    http_method = http_method.toUpperCase()
    if http_method in [ 'POST', 'PUT' ]
        data = arg.shift()

    headers = if typeof args[0] == 'object' then args.shift() else {}

    if http_method == 'POST'
        request = new Net.HTTP.Post path, headers
    else if http_method == 'PUT'
        request = new Net.HTTP.Put path, headers
    else if http_method == 'GET'
        request = new Net.HTTP.Get path, headers
    else if http_method == 'DELETE'
        request = new Net.HTTP.Delete path, headers
    else if http_method == 'HEAD'
        request = new Net.HTTP.Head path, headers
    else
        throw new ArgumentError "Don't know how to handle http_method: #{http_method}"

    if typeof data == 'object'
        request.setFormData data
    else if data?
        request.body = data.toString()
    request
    


class OAuth.Consumer
    constructor: (consumer_key, @consumer_secret, options = {}) ->
        @_key = consumer_key
        @_secret = consumer_secret

        @_options = merge default_options, options

    @getter 'key', -> @_key

    @getter 'secret', -> @_secret

    @getter 'options', -> @_options

    @getter 'site', -> @_options["site"]

    
    getAccessTokenPath: -> @_options["access_token_path"]

    getAccessTokenURL: ->
        @_options["access_token_url"] or @_options["site"] + @_options["access_token_path"]

    isAccessTokenURL: -> @_options["access_token_url"]?

    getAuthorizePath: -> @_options["authorize_path"]

    getAuthorizeURL: -> @_options["authorize_url"] or @_options["site"] + @_options["authorize_path"]

    isAuthorizeURL: -> @_options["authorize_url"]?

    createSignedRequest: (http_method, path, token = null, request_options = {}, args...) ->
        request = createHttpRequest http_method, path, args
        this.sign request, token, request_options
        request

    getAccessToken: (request_token, request_options = {}, args...) ->
        access_token_url = if this.isAccessTokenURL() then this.accessTokenURL() else this.accessTokenPath()
        if typeof args[args.length - 1] is 'function'
            #is_block_given = true
            block = args.pop()
        else
            #is_block_given = false
            block = null

        response = this.tokenRequest( this.getHttpMethod(), access_token_url, request_token, request_options, args, block )
        OAuth.AccessToken.fromHash this, response

    getRequestToken: (request_options = {}, args...) ->
        if typeof args[args.length - 1] is 'function'
            is_block_given = true
            block = args.pop()
        else
            is_block_given = false
            block = null

        request_options["oauth_callback"] or= OAuth.OUT_OF_BAND unless request_options["exclude_callback"]?

        request_token_url = if this.isRequestTokenURL() then this.getRequestTokenURL() else this.getRequestTokenPath()
        if is_block_given
            response = this.tokenRequest( this.getHttpMethod(), request_token_url, null, request_options, args, block )
        else
            response = this.tokenRequest( this.getHttpMethod(), request_token_url, null, request_options, args )

        OAuth.RequestToken.fromHash this, response

    getHttpMethod: ->
        @_http_method or= @_options["http_method"] or "post"

    getProxy: -> @_options["proxy"]

    request: (http_method, path, token = null, request_options = {}, args...) ->
        if typeof args[args.length - 1] is 'function'
            is_block_given = true
            block = args.pop()
        else
            is_block_given = false
            block = null

        if /^\//.test path
            @_http = createHttp path
            _uri = URI.parse path
            if _uri.getQuery()?
                path = "#{_uri.getPath()}#{_uri.getQuery()}"
            else
                path = "#{_uri.getPath()}"

        request = this.createSignedRequest http_method, path, token, request_options, args

        return null if is_block_given and block( request ) == "done"

        response = this.getHttpRequest().request request

        if !( headers = response.toHash()["www-authenticate"] )?
            temp_header = []
            for h in headers
                temp_header = h if /^OAuth/.test h
            if temp_header.length > 0 and /oauth_problem/.test temp_header[0]
                params = OAuth.Helper.parseHeader temp_header[0]
                throw new OAuth.Problem params.delete( "oauth_problem" ), response, params 
        response

    getRequestEndpoint: ->
        return null unless @_options["request_endpoint"]?
        @_options["request_endpoint"].toString()

    getRequestTokenPath: -> @_options["request_token_path"]

    getRequestTokenURL: -> @_options["request_token_url"]

    isRequestTokenURL: -> @_options["request_token_url"]?

    getScheme: -> @_options["scheme"]

    sign: (request, token = null, request_options = {}) ->
        request.oauth @_http, this, token, merge( @_options, request_options )

    getSignatureBaseString: (request, token = null, request_options = {}) ->
        request.getSignatureBaseString @_http, this, token, merge( @_options, request_options )

    tokenRequest: (http_method, path, token = null, request_options = {}, args...) ->
        if typeof args[args.length - 1] is 'function'
            is_block_given = true
            block = args.pop()
        else
            is_block_given = false
            block = null

        response = this.request http_method, path, token, request_options, args

        response.code = parseInt response.status
        if 200 <= response.code < 300
            if is_block_given
                block response.body
            else
                temp_headers = {}
                ( CGI.parse response.body ).inject (k, v) ->
                    temp_headers[k] = v[0]
                    #temp_headers[k]
                    temp_headers
        else if 300 <= response.code < 400
            uri = URI.parse response.header["location"]
            response.error if uri.path == path
            this.tokenRequest http_method, uri.path, request_options, args
        else if 400 <= response.code < 500
            throw new OAuth.Unathorized response
        else
            response.error

    uri: (custom_uri = null) ->
        if custom_uri?
            @_uri = custom_uri
            @_http = this.createHttp()
        else
            @_uri = URI.parse this.site
        

exports = OAuth.Consumer
module.exports = OAuth.Consumer
