OAuth = require '../lib/oauth'


describe "OAuth には", ->

    it "VERSION フィールドがあります。", ->
        expect( OAuth.VERSION? ).toBeDefined

    it "OUT_OF_BAND フィールドがあります。", ->
        expect( OAuth.OUT_OF_BAND ).toBeDefined

    it "PARAMETER フィールドがあります。", ->
        expect( OAuth.PARAMETERS ).toBeDefined

    it "RESERVED_CHARATERS フィールドがあります。", ->
        expect( OAuth.RESERVED_CHARACTERS ).toBeDefined
