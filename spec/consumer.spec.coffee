OAuth = require '../lib/oauth'
OAuth.Consumer = require '../lib/consumer'


describe "OAuth.Consumer", ->
    consumer = null

    beforeEach ->
        consumer = new OAuth.Consumer( 'YOUR CONSUMER KEY', 'YOUR CONSUMER SECRET', { site: 'http://api.twitter.com' } )

    it "key プロパティがあるはず。", ->
        expect( consumer.key ).toBeDefined

    it "secret プロパティがあるはず。", ->
        expect( consumer.secret ).toBeDefined

    it "options プロパティがあるはず。", ->
        expect( consumer.options ).toBeDefined

    it "site プロパティがあるはず。", ->
        expect( consumer.site ).toBeDefined

    it "key プロパティは「YOUR CONSUMER KEY」であるはず。", ->
        expect( consumer.key ).toBe 'YOUR CONSUMER KEY'

    it "secret プロパティは「YOUR CONSUMER KEY」であるはず。", ->
        expect( consumer.secret ).toBe 'YOUR CONSUMER SECRET'

    it "options プロパティはハッシュであるはず。", ->
        to_s = Object::toString
        expect( to_s.call consumer.options ).toBe '[object Object]'

    it "site プロパティは「http://api.twitter.com」であるはず。", ->
        expect( consumer.site ).toBe 'http://api.twitter.com'

    it "getAccessTokenPath() が返すのは「/oauth/access_token」のはず。", ->
        expect( consumer.getAccessTokenPath() ).toBe '/oauth/access_token'

    it "getAccessTokenURL() が返すのは「http://api.twitter.com/oauth/access_token」のはず。", ->
        expect( consumer.getAccessTokenURL() ).toBe 'http://api.twitter.com/oauth/access_token'

    it "isAccessTokenURL() が返すのは偽のはず。", ->
        expect( consumer.isAccessTokenURL() ).toBe false

    it "getAuthorizePath() が返すのは「/oauth/authorize」のはず。", ->
        expect( consumer.getAuthorizePath() ).toBe '/oauth/authorize'

    it "getAuthorizeURL() が返すのは「http://api.twitter.com/oauth/authorize」のはず。", ->
        expect( consumer.getAuthorizeURL() ).toBe 'http://api.twitter.com/oauth/authorize'

    it "isAuthorizeURL() が返すのは偽のはず。", ->
        expect( consumer.isAuthorizeURL() ).toBe false

    it "getHttpMethod() が返すのは「post」のはず。", ->
        expect( consumer.getHttpMethod() ).toBe 'post'

    it "getRequestTokenPath() が返すのは「/oauth/request_token」のはず。", ->
        expect( consumer.getRequestTokenPath() ).toBe '/oauth/request_token'

    it "getRequestTokenURL() が返すのは「http://api.twitter.com/oauth/request_token」のはず。", ->
        expect( consumer.getRequestTokenURL() ).toBe 'http://api.twitter.com/oauth/request_token'

    it "isRequestTokenURL() が返すのは偽のはず。", ->
        expect( consumer.isRequestTokenURL() ).toBe false
