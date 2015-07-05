function buNumbersUtils() as Object
    if(m.buNumbersUtils = Invalid) then
        m.buNumbersUtils = {
            max: function(arr as Dynamic) as Dynamic
                max = arr[0]

                if(buTypeUtils().isNumber(max) = false) then
                    return Invalid
                end if

                if(buArrayUtils().isEmpty(arr)) then
                    return Invalid
                end if

                for each el in arr
                    if(el > max) then
                        max = el
                    end if
                end for

                return max
            end function,

            min: function(arr as Dynamic) as Dynamic
                min = arr[0]

                if(buTypeUtils().isNumber(min) = false) then
                    return Invalid
                end if

                if(buArrayUtils().isEmpty(arr)) then
                    return Invalid
                end if

                for each el in arr
                    if(el < min) then
                        min = el
                    end if
                end for

                return min
            end function,

            ceiling: function(value as Dynamic) as Integer
                if(buTypeUtils().isNumber(value) = false) then
                    return 0
                end if

                if value - int(value) > 0 then
                    return int(value) + 1
                else
                    return int(value)
                end if
            end function,

            floor: function(value as Dynamic) as Integer
                if(buTypeUtils().isNumber(value) = false) then
                    return 0
                end if

                return int(value)
            end function,

            round: function(value as Dynamic) as Integer
                if(buTypeUtils().isNumber(value) = false) then
                    return 0
                end if
                
                if value - int(value) >= 0.5 then
                    return int(value) + 1
                else
                    return int(value)
                end if
            end function
        }
    end if

    return m.buNumbersUtils
end function
