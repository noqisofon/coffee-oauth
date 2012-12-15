utils = require '../extern/utils'


OAuth = exports? and exports or @OAuth = {}

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

exports.Problem = OAuth.Problem
module.exports.Problem = OAuth.Problem
