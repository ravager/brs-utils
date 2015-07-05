'
' Utils to check the different types
'
function buTypeUtils() as Object
    if(m.buTypeUtils = Invalid) then
        m.buTypeUtils = {
            isString: function(obj as Dynamic) as Boolean
                if obj = Invalid return false
                if getInterface(obj, "ifString") = Invalid return false
                return true
            end function

            isBool: function(obj as Dynamic) as Boolean
                if obj = Invalid return false
                if getInterface(obj, "ifBoolean") = Invalid return false
                return true
            end function

            isInt: function(obj as Dynamic) as Boolean
                if obj = Invalid return false
                if getInterface(obj, "ifInt") = Invalid return false
                return true
            end function

            isArray: function(obj as Dynamic) as Boolean
                if obj = Invalid return false
                if getInterface(obj, "ifArray") = Invalid return false
                return true
            end function

            isList: function(obj as Dynamic) as Boolean
                if obj = Invalid return false
                if getInterface(obj, "ifList") = Invalid return false
                return true
            end function

            isFloat: function(obj as Dynamic) as Boolean
                if obj = Invalid return false
                if getInterface(obj, "ifFloat") = Invalid return false
                return true
            end function

            isDouble: function(obj as Dynamic) as Boolean
                if obj = Invalid return false
                if getInterface(obj, "ifDouble") = Invalid return false
                return true
            end function,

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

            isDateTime: function(obj as Dynamic) as Boolean
                if obj = Invalid return false
                if getInterface(obj, "ifDateTime") = Invalid return false
                return true
            end function
        }
    endif
    return m.buTypeUtils
end function
