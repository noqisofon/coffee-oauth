namespace = require 'namespace'

console.log namespace

namespace 'Hello.World', (exports) ->
    exports.hi = -> console.log 'Hi World!'

namespace 'Say.Hello', (exports, top) ->
    exports.fn = top.Hello.World.hi()

Say.Hello.fn()
