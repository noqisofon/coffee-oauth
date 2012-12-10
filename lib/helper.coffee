URI = require 'extern/uri'
OAuth = require 'oauth'

OAuth.Helper
    escape: (value) ->
        #try
            URI.escape value.toString(), OAuth.RESERVED_CHARACTERS
        #catch argument_error
        #    URI.escape value.toString().forseEncoding( Encoding.UTF_8 ), OAuth.RESERVED_CHARACTERS

exports.OAuth.Helper = OAuth.Helper
