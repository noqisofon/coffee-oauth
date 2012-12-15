class Hash
    @fromHash: (ary) ->
        ret = {}
        len = ary.length
        for i in [0..len-1]
            ret[ary[i]] = ary[i + 1]
        ret

module.exports = Hash
