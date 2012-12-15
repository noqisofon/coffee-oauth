Function::attribute = (prop, desc) ->
    Object.defineProperty @prototype, prop, desc


Function::getter = (prop, get) ->
    Object.defineProperty @prototype, prop, { get, configurable: yes }


Function::setter = (prop, set) ->
    Object.defineProperty @prototype, prop, { set, configurable: yes }


extend = (obj, mixin) ->
    obj[name] = method for name, method of mixin
    obj


include = (klass, mixin) ->
    extend klass.prototype, mixin


exports.extend = extend
exports.include = include
