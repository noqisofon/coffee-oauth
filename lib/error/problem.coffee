utils = require '../extern/utils'

OAuth = {} unless OAuth?
OAuth.Unauthorized = require './unauthorized'


class OAuth.Problem extends OAuth.Unauthorized
    constructor: (problem, request = null, params = {}) ->
        super request
        @_problem = problem
        @_params = params

    @getter 'params', -> @_params

    @getter 'problem', -> @_problem

    toString: ->
        unless typeof @_problem == 'string'
            @_problem.toString()
        else
            @_problem

exports = OAuth.Problem
module.exports = OAuth.Problem
