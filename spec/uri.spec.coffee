URI = require '../lib/extern/uri'


describe 'URI', ->

    uri = null

    beforeEach ->
        uri = URI.parse 'https://github.com/noqisofon/coffee-oauth'

    it "scheme プロパティがあるはず。", ->
        expect( uri.scheme ).toBeDefined

    it "host プロパティがあるはず。", ->
        expect( uri.host ).toBeDefined

    it "port プロパティがあるはず。", ->
        expect( uri.port ).toBeDefined

    it "path プロパティがあるはず。", ->
        expect( uri.path ).toBeDefined

    it "schme プロパティは「https」なはず。", ->
        expect( uri.scheme ).toBe 'https'

    it "host プロパティは「github.com」はず。", ->
        expect( uri.host ).toBe 'github.com'

    it "path プロパティは「noqisofon/coffee-oauth」なはず", ->
        expect( uri.path ).toBe 'noqisofon/coffee-oauth'

    it "port プロパティは「null」なはず。", ->
        expect( uri.port ).toBeNull
