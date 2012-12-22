Net = require '../lib/extern/net/http'



describe "Net.HTTP は", ->

    http = null

    beforeEach ->
        http = new Net.HTTP 'api.twitter.com'

    it "address プロパティがあるはず。", ->
        expect( http.address ).toBeDefined

    it "port プロパティがあるはず。", ->
        expect( http.port ).toBeDefined

    it "openTimeout プロパティがあるはず。", ->
        expect( http.openTimeout ).toBeDefined

    it "readTimeout プロパティがあるはず。", ->
        expect( http.readTimeout ).toBeDefined
        
