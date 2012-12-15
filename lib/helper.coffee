URI = require './extern/uri'
Hash = require './extern/hash'

OAuth = require './oauth'

OAuth.Problem = require './error/problem'


OAuth.Helper =
    escape: (value) ->
        #try
            encodeURIComponent value.toString(), OAuth.RESERVED_CHARACTERS
        #catch argument_error
        #    URI.escape value.toString().forseEncoding( Encoding.UTF_8 ), OAuth.RESERVED_CHARACTERS

    parseHeader: (header) ->
        params = header[6..header.length].split /[,=&]/

        throw OAuth.Problem.new "Invalid authorization header" if params.size % 2 != 0

        params = params.map (v) ->
            val = unescape v.strip
            val.replace /^\"(.*)\"$/, '\\1'

        Hash.fromArray params.flatten()

exports.Helper = OAuth.Helper
module.exports.Helper = OAuth.Helper
