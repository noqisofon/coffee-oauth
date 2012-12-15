OAuth = require 'oauth'


console.log "version: #{OAuth.VERSION}"
console.log "out of band: #{OAuth.OUT_OF_BAND}"
console.log "parameters:"
console.log parameter for parameter in OAuth.PARAMETERS
console.log "reserved characters: #{OAuth.RESERVED_CHARACTERS}"
