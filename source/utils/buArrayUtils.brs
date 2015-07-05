'
' Set of utils to work on and transform arrays
'
function buArrayUtils() as Object
    if(m.buArrayUtils = Invalid) then
        m.buArrayUtils = {
            ' Compares each element of an array
            equals: function(arr1 as Dynamic, arr2 as Dynamic) as Boolean
                if(not buTypeUtils().isArray(arr1)) then
                    return false
                end if

                if(not buTypeUtils().isArray(arr2)) then
                    return false
                end if

                if(arr1.count() <> arr2.count()) then
                    return false
                end if

                for i = 0 to arr1.count() - 1 step +1
                    if(arr1[i] <> arr2[i]) then
                        return false
                    end if
                end for

                return true
            end function,

            isEmpty: function(arr as Dynamic) as Boolean
                if(arr = Invalid) then
                    return true
                endif

                return arr.count() = 0
            end function,

            contains: function(arr as Dynamic, element as Dynamic) as Boolean
                if(m.isEmpty(arr)) then
                    return false
                endif

                if(buTypeUtils().isArray(arr) = false) then
                    return false
                endif

                if(buTypeUtils().isComparable(element) = false) then
                    return false
                endif

                for each el in arr
                    ' without a proper equals model this is the best we can do
                    if(el = element) then
                        return true
                    end if
                end for

                return false
            end function,

            indexOf: function(arr as Dynamic, element as Dynamic) as Integer
                if(buTypeUtils().isArray(arr) = false) then
                    return -1
                endif

                if(m.isEmpty(arr)) then
                    return -1
                endif

                if(buTypeUtils().isComparable(element) = false) then
                    return -1
                endif

                for i = 0 to arr.count() - 1 step +1
                    if(arr[i] = element) then
                        return i
                    end if
                end for

                return -1
            end function,

            add: function(arr as Dynamic, index as Integer, element as Dynamic) as Dynamic
                if(buTypeUtils().isArray(arr) = false) then
                    return Invalid
                endif

                if(index < 0) then
                    return arr
                endif

                if(m.isEmpty(arr)) then
                    return [element]
                endif

                if(index = arr.count()) then
                    arr.push(element)
                    return arr
                endif

                if(index = 0) then
                    arr.unshift(element)
                    return arr
                endif

                if(index > arr.count() + 1) then
                    return arr
                endif

                newArray = []
                for i = 0 to arr.count() - 1 step +1
                    if(index = i) then
                        newArray.push(element)
                    endif
                    newArray.push(arr[i])
                end for

                return newArray
            end function

            replace: function(arr as Dynamic, index as Integer, element as Dynamic) as Dynamic
                if(buTypeUtils().isArray(arr) = false) then
                    return Invalid
                endif

                if(index < 0) then
                    return arr
                endif

                if(m.isEmpty(arr)) then
                    return []
                endif

                if(index > arr.count() - 1) then
                    return arr
                endif

                newArray = []
                for i = 0 to arr.count() - 1 step +1
                    if(index = i) then
                        newArray.push(element)
                    else
                        newArray.push(arr[i])
                    endif
                end for

                return newArray
            end function,

            subArray: function(arr as Dynamic, startIndex as Integer, endIndex as Integer) as Dynamic
                if(m.isEmpty(arr)) then
                    return []
                endif

                if(startIndex < 0) then
                    startIndex = 0
                end if

                if(endIndex > arr.count() - 1) then
                    endIndex = arr.count() - 1
                end if

                if(startIndex > endIndex) then
                    return Invalid
                end if

                newArray = []
                for i = startIndex to endIndex step +1
                    newArray.push(arr[i])
                end for

                return newArray
            end function,

            toString: function(arr as Dynamic) as String
                return buStringUtils().toString(arr)
            end function

        }
    end if
    return m.buArrayUtils
end function
