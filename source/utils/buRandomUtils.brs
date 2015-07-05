'
' Set of utilities to generate random values
'
function buRandomUtils() as Object
    if(m.buRandomUtils = Invalid) then
        m.buRandomUtils = {

            chars:      "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz",
            hexchars:   "0123456789ABCDEF",

            nextInteger: function() as Integer
                return rnd(2147483647)
            end function,

            nextFloat: function() as Float
                return rnd(0)
            end function,

            nextString: function(length = 20 as Integer) as String
                randomString = ""

                for i = 1 to length step +1
                    randomString = randomString + m.chars.mid(rnd(62) - 1, 1)
                end for

                return randomString
            end function,

            nextHexString: function(length = 6 as Integer) as String
                randomString = ""

                for i = 1 to length step +1
                    randomString = randomString + m.hexchars.mid(rnd(16) - 1, 1)
                end for

                return randomString
            end function,

            ' Generates a RFC-4122 random UUID xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
            uuid: function() as String
                arr = [
                    m.nextHexString(8),
                    m.nextHexString(4),
                    m.nextHexString(4),
                    m.nextHexString(4),
                    m.nextHexString(12)
                ]
                return buStringUtils().join(arr, "-")
            end function
        }

    end if
    return m.buRandomUtils
end function
