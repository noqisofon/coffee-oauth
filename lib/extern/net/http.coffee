utils = require '../utils'
Module = require '../module'
URI = require '../uri'

OAuth = {}

OAuth.Client = require '../../client'
OAuth.Helper = require '../../helper'

Net = {}


Net.HTTPHeader =
    addField: (key, val) -> @_headers[key] = val

    fetch: (key) -> @_headers[key]

    setFormData: (params, separator = '&') ->
        @_params = params
        @_separator = separator unless @_separator == separator

    hasKey: (key) -> @_headers[key]?

    each: (block) ->
        block key, @_headers[key] for key in @_headers


getOAuthHelperOptions = (that, http, consumer, token, options) ->
    {
        request_uri: getOauthFullRequestURI that, http, options
        consumer: consumer
        token: token
        scheme: 'header'
        signature_method: null
        nonce: null
        timestamp: null
     }.merge options


getOauthFullRequestURI = (that, http, options) ->
    uri = URI.parse that.path
    uri.host = http.address
    uri.port = http.port

    if options['request_endpoint']? and options['site']?
        is_https = options['site'].match /^https:\/\//
        if is_https
            uri.host = options['site'].substring 'https://'.length
        else
            uri.host = options['site'].substring 'http://'.length
        uri.port or= if is_https then 443 else 80

    if http.useSSL? and http.useSSL
        uri.scheme = 'https'
    else
        uri.scheme = 'http'

    uri.toString()


isOAuthBodyHashRequired = (that) ->
    false


setOAuthHeader = (that) ->
    that.setFormData that._oauth_helper.stringify_keys( that.parametersWithOAuth )
    params_with_sig = that._oauth_helper.parameters.merge
        oauth_signature: that._oauth_helper.signature
    that.setFormData that._oauth_helper.stringify_keys( params_with_sig )


class Net.HTTP
    constructor: (@_addess, @_port = 80, @_proxy_addr = null, @_proxy_port = null, @_proxy_user = null, @_proxy_pass = null) ->

    #@portForm: (uri, params) ->

    @getter 'address', -> @_address

    @getter 'port', -> @_port

    @attribute 'openTimeout',
        get: -> @_open_timeout
        set: (value) -> @_open_timeout = value

    @attribute 'readTimeout',
        get: -> @_read_timeout
        set: (value) -> @_read_timeout = value

    request: (request_object) ->
        


class Net.HTTPRequest extends Module
    @include Net.HTTPHeader
    @include OAuth.Helper

    constructor: (path, init_headers = null) ->
        @_path = path
        @_headers = if init_headers? then init_headers else {}
        @_method = null
        @_body = null

    @attribute 'body',
        get: -> @_body
        set: (value) -> @_body = value

    @getter 'path', -> @_path

    @getter 'method', -> @_method

    bodyExists: -> @_body?

    oauth: (http, consumer = null, token = null, options = {}) ->
        helper_options = getOAuthHelperOptions this, http, consumer, token, options

        @_oauth_helper = new OAuth.Client.Helper this, helper_options
        @_oauth_helper.amendUserAgentHeader this
        @_oauth_helper.hashBody() if isOAuthBodyHashRequired( this )

        this.send "set_oauth_#{helper_options['scheme']}"


class Net.HTTP.Post extends Net.HTTPRequest
    constructor: (path, init_headers = null) ->
        super path, init_headers
        @_method = 'POST'


class Net.HTTP.Put extends Net.HTTPRequest
    constructor: (path, init_headers = null) ->
        super path, init_headers
        @_method = 'PUT'


class Net.HTTP.Get extends Net.HTTPRequest
    constructor: (path, init_headers = null) ->
        super path, init_headers
        @_method = 'GET'


class Net.HTTP.Delete extends Net.HTTPRequest
    constructor: (path, init_headers = null) ->
        super path, init_headers
        @_method = 'DELETE'


class Net.HTTP.Head extends Net.HTTPRequest
    constructor: (path, init_headers = null) ->
        super path, init_headers
        @_method = 'HEAD'


class Net.HTTPResponse
    

exports = Net
module.exports = Net
