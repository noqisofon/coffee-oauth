OAuth = require '../lib/oauth'


describe "OAuth には", ->

    it "VERSION フィールドがあるはず。", ->
        expect( OAuth.VERSION ).toBeDefined

    it "OUT_OF_BAND フィールドがあるはず。", ->
        expect( OAuth.OUT_OF_BAND ).toBeDefined

    it "PARAMETER フィールドがあるはず。", ->
        expect( OAuth.PARAMETERS ).toBeDefined

    it "RESERVED_CHARACTERS フィールドがあるはず。", ->
        expect( OAuth.RESERVED_CHARACTERS ).toBeDefined


    it "VERSION フィールドは文字列であるはず。", ->
        expect( typeof OAuth.VERSION ).toBe 'string'

    it "OUT_OF_BAND フィールドは文字列であるはず。", ->
        expect( typeof OAuth.OUT_OF_BAND ).toBe 'string'

    it "PARAMETERS フィールドは配列であるはず。", ->
        to_s = Object::toString
        expect( to_s.call OAuth.PARAMETERS ).toBe '[object Array]'

    it "RESERVED_CHARACTERS フィールドは正規表現であるはず。", ->
        to_s = Object::toString
        expect( to_s.call OAuth.RESERVED_CHARACTERS ).toBe '[object RegExp]'
