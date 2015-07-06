'
' A very simplistic Set implementation. Very hard to implement
' without object hashes. Only works with BrightScript primitives
' @returns {Object} a buSet
' @license MIT
function buSet(data = [] as Dynamic) as Object

    return {
        _data : data,

        add: function(element as Object) as Boolean
           if not m.contains(element) then
                m._data.push(element)
                return true
            end if
            return false
        end function,

        remove: function(element as Object) as Boolean
            for i = 0 to m._data.count() - 1 step +1
                if m._data[i] = element then
                    return m._data.delete(i)
                end if
            end for
            return false
        end function,

        contains: function(element as Object) as Boolean
            for each el in m._data
                if el = element then
                    return true
                end if
            end for
            return false
        end function,

        get: function(index as Integer) as Object
            if index >= 0 and index < m._data.count() then
               return m._data[index]
            end if
            return Invalid
        end function

        count: function() as Integer
            return m._data.count()
        end function
    }

end function
