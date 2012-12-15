utils = require '../extern/utils'

OAuth = {} unless OAuth?
OAuth.Error = require './error'


class OAuth.Unauthorized extends OAuth.Error
    consutructor: (request = null) ->
        @_request = request

    @getter 'request', -> @_request

    toString: -> [ @_request.code.toString(), @_request.message ].join ' '

exports = OAuth.Unauthorized
module.exports = OAuth.Unauthorized
