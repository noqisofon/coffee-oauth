utils = require '../extern/utils'


OAuth = exports? and exports or @OAuth = {}

OAuth.Error = require './error'


class OAuth.Unauthorized extends OAuth.Error
    consutructor: (request = null) ->
        @_request = request

    @getter 'request', -> @_request

    toString: -> [ @_request.code.toString(), @_request.message ].join ' '

exports.Unauthorized = OAuth.Unauthorized
module.exports.Unauthorized = OAuth.Unauthorized
