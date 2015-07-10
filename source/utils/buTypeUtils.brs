'
' Utils to check the different types
'
' @singleton
' @returns {Object} the buTypeUtils singleton
' @license MIT
function buTypeUtils() as Object
    if(m.buTypeUtils = Invalid) then
        m.buTypeUtils = {
            isString: function(obj as Dynamic) as Boolean : return m.isType(obj, "ifString") : end function,

            isBool: function(obj as Dynamic) as Boolean : return m.isType(obj, "ifBoolean") : end function,

            isBoolean: function(obj as Dynamic) as Boolean : return m.isBool(obj) : end function,

            isInt: function(obj as Dynamic) as Boolean : return m.isType(obj, "ifInt") : end function,

            isInteger: function(obj as Dynamic) as Boolean : return m.isInt(obj) : end function,

            isArray: function(obj as Dynamic) as Boolean : return m.isType(obj, "ifArray") : end function,

            isList: function(obj as Dynamic) as Boolean : return m.isType(obj, "ifList") : end function,

            isFloat: function(obj as Dynamic) as Boolean : return m.isType(obj, "ifFloat") : end function,

            isDouble: function(obj as Dynamic) as Boolean : return m.isType(obj, "ifDouble") : end function,

            isComparable: function(obj as Dynamic) as Boolean
                if (obj = Invalid) then return true
                if (m.isString(obj)) then return true
                if (m.isBool(obj)) then return true
                if (m.isInt(obj)) then return true
                if (m.isFloat(obj)) then return true
                if (m.isDouble(obj)) then return true
                return false
            end function,

            isNumber: function(obj as Dynamic) as Boolean
                if (m.isInt(obj)) then return true
                if (m.isFloat(obj)) then return true
                if (m.isDouble(obj)) then return true
                return false
            end function,

            isDateTime: function(obj as Dynamic) as Boolean : return m.isType(obj, "ifDateTime") : end function,

            isObject: function(obj as Dynamic) as Boolean : return m.isType(obj, "ifAssociativeArray") : end function,

            isType: function (obj as Dynamic, ifType as String) as Boolean
                if obj = Invalid return false
                if GetInterface(obj, ifType) = Invalid return false
                return true
            end function
        }
    endif
    return m.buTypeUtils
end function
