'
' Set of utils to work on and transform arrays
' @singleton
' @returns {Object} the buArrayUtils singleton
' @license MIT
function buArrayUtils() as Object
    if(m.buArrayUtils = Invalid) then
        m.buArrayUtils = {

            ' Compares each element of an array. Only works with native types
            ' @param {Dynamic} arr1 - the first array to compare
            ' @param {Dynamic} arr2 - the second array to compare
            ' @returns {Boolean} One level deep equality
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


            ' Is empty
            ' @param {Dynamic} arr - the array to check
            ' @returns {Boolean} array is empty or Invalid
            isEmpty: function(arr as Dynamic) as Boolean
                if(arr = Invalid) then
                    return true
                endif

                return arr.count() = 0
            end function,

            ' Checks if the element is in the array.
            ' @param {Dynamic} arr - the array to check
            ' @param {Dynamic} element - the element to search
            ' @returns {Boolean} array contains the element
            contains: function(arr as Dynamic, element as Dynamic) as Boolean
                return m.indexOf(arr, element) >= 0
            end function,

            ' Checks if the element is in the array and return its position in the array
            ' @param {Dynamic} arr - the array to check
            ' @param {Dynamic} element - the element to search
            ' @returns {Integer} index where the element is located or -1 if not present or cant be searched
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

            ' Adds an element to an array in the given index
            ' @param {Dynamic} arr - the array to modify
            ' @param {Integer} index - where to insert the element
            ' @param {Dynamic} element - the element to insert
            ' @returns {Dynamic} array with or without the element
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

            ' Replaces an element on an array in the given index
            ' @param {Dynamic} arr - the array to modify
            ' @param {Integer} index - where to replace the element
            ' @param {Dynamic} element - the element to replace
            ' @returns {Dynamic} array with or without the element
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

            ' Returns a part of the array
            ' @param {Dynamic} arr - the array to modify
            ' @param {Integer} startIndex - where to start
            ' @param {Integer} endIndex - where to end
            ' @returns {Dynamic} array part of the original array
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

            ' Converts an array to String like "[1,2,3]"
            ' @param {Dynamic} arr - the array to convert
            ' @returns {String} arr converted to string
            toString: function(arr as Dynamic) as String
                return buStringUtils().toString(arr)
            end function

        }
    end if
    return m.buArrayUtils
end function
