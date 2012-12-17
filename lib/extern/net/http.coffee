utils = require '../utils'
Module = require '../module'
URI = require '../uri'

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


class Net.HTTPRequest extends Module
    @include Net.HTTPHeader

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


class Net.HTTP
    constructor: (@_addess, @_port = 80, @_proxy_addr = null, @_proxy_port = null, @_proxy_user = null, @_proxy_pass = null) ->

    #@portForm: (uri, params) ->

    @getter 'address', -> @_address

    @getter 'port', -> @_port

    @attribute 'openTimeout',
        get: -> @_open_timeout
        set: (value) -> @_open_timeout

    @attribute 'readTimeout',
        get: -> @_read_timeout
        set: (value) -> @_read_timeout

    request: (request_object) ->
        


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


exports = Net
module.exports = Net
