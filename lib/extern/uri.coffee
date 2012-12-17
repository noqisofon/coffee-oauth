utils = require './utils'
Module = require './module'


class URI
    constructor: (path, host = null, scheme = null, port = null) ->
        @_host = host
        @_path = path
        @_port = port
        @_scheme = scheme
        @_query = null

    @parse: (uri_str) ->
        parts = uri_str.split /\//
        if /^https?/.test parts[0]
            scheme = parts[0].substring 0, parts[0].indexOf ':'
        else
            scheme = null

        if parts[1] == ''
            host_parts = parts[2].split ':'
            if host_parts.length > 1
                host = host_parts.shift()
                port = parseInt host_parts.shift(), 10
            else
                host = parts[2]
                port = null
        else
            host = null

        if scheme != null and host != null
            path = parts[3..].join '/'
        else
            path = uri_str

        new URI path, host, scheme, port

    @attribute 'scheme',
        get: -> @_scheme
        set: (value) -> @_scheme = value

    @attribute 'host',
        get: -> @_host
        set: (value) -> @_host = value

    @attribute 'port',
        get: -> @_port
        set: (value) -> @_port = value

    @attribute 'path',
        get: -> @_path
        set: (value) -> @_path = value

    @attribute 'query',
        get: -> @_query
        set: (value) -> @_query = value

    isRelative: -> not @_scheme?
        

    toString: ->
        [ "#{@_scheme}/", @_host, @_path ].join '/'
        

exports = URI
module.exports = URI
