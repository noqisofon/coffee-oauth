OAuth = require '../lib/oauth'
OAuth.Consumer = require '../lib/consumer'


describe "OAuth.Consumer", ->
    consumer = null
    to_s = Object::toString

    beforeEach ->
        consumer = new OAuth.Consumer( 'vDqmnjgpz8h5sFbeWAsMTg', 'lz5NKRhIDgs6togZU7DhH69A4kskQewEWX81frcUumE', { site: 'http://api.twitter.com' } )

    it "key プロパティがあるはず。", ->
        expect( consumer.key ).toBeDefined

    it "secret プロパティがあるはず。", ->
        expect( consumer.secret ).toBeDefined

    it "options プロパティがあるはず。", ->
        expect( consumer.options ).toBeDefined

    it "site プロパティがあるはず。", ->
        expect( consumer.site ).toBeDefined

    it "httpMethod プロパティがあるはず。", ->
        expect( consumer.httpMethod ).toBeDefined

    it "proxy プロパティがあるはず。", ->
        expect( consumer.proxy ).toBeDefined

    it "scheme プロパティがあるはず。", ->
        expect( consumer.scheme ).toBeDefined

    it "http プロパティがあるはず。", ->
        expect( consumer.http ).toBeDefined

    it "key プロパティは「vDqmnjgpz8h5sFbeWAsMTg」であるはず。", ->
        expect( consumer.key ).toBe 'vDqmnjgpz8h5sFbeWAsMTg'

    it "secret プロパティは「lz5NKRhIDgs6togZU7DhH69A4kskQewEWX81frcUumE」であるはず。", ->
        expect( consumer.secret ).toBe 'lz5NKRhIDgs6togZU7DhH69A4kskQewEWX81frcUumE'

    it "options プロパティはハッシュであるはず。", ->
        expect( to_s.call consumer.options ).toBe '[object Object]'

    it "site プロパティが返すのは「http://api.twitter.com」であるはず。", ->
        expect( consumer.site ).toBe 'http://api.twitter.com'

    it "httpMethod プロパティが返すのは「post」のはず。", ->
        expect( consumer.httpMethod ).toBe 'post'

    it "http プロパティが返すのは null 以外のはず。", ->
        expect( consumer.http ).toNotBe null

    it "proxy プロパティが返すのは null のはず。", ->
        expect( consumer.proxy ).toBe null

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

    it "getRequestTokenPath() が返すのは「/oauth/request_token」のはず。", ->
        expect( consumer.getRequestTokenPath() ).toBe '/oauth/request_token'

    it "getRequestTokenURL() が返すのは「http://api.twitter.com/oauth/request_token」のはず。", ->
        expect( consumer.getRequestTokenURL() ).toBe 'http://api.twitter.com/oauth/request_token'

    it "isRequestTokenURL() が返すのは偽のはず。", ->
        expect( consumer.isRequestTokenURL() ).toBe false

    it "getRequestToken() は null 以外を返すはず。", ->
        expect( consumer.getRequestToken() ).toBeNot null

    it "getUri() は URI オブジェクトを返すはず。", ->
        expect( consumer.getUri().toString() ).toBe 'http://api.twitter.com/'
        
