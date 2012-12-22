Object::clone = -> JSON.parse JSON.stringify( this )


Object::merge = (another) ->
    # opts = this.clone()
    opts = {}
    opts[key] = this[key] for key of this

    #another = another.clone()
    for key of another
        opts[key] = another[key] unless opts[key]?
    opts


Function::attribute = (prop, desc) ->
    Object.defineProperty @prototype, prop, desc


Function::getter = (prop, get) ->
    Object.defineProperty @prototype, prop, { get, configurable: yes }


Function::setter = (prop, set) ->
    Object.defineProperty @prototype, prop, { set, configurable: yes }


Array::include = (value) ->
    for i in this
        return true if this[i] == value
    false


extend = (obj, mixin) ->
    obj[name] = method for name, method of mixin
    obj


include = (klass, mixin) ->
    extend klass.prototype, mixin


exports.extend = extend
exports.include = include
