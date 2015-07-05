'
' A container object which may or may not contain a non-Invalid value.
' If a value is present, isPresent() will return true and get() will return the value.
'
function buOptional(value = Invalid as Dynamic) as Object

    optional = {

        _value: value,

        get: function() as Dynamic
            return m._value
        end function,

        ifPresent: function(func as Function) as Dynamic
            if(m._value <> Invalid) then
                return func(m._value)
            end if
            return Invalid
        end function,

        isPresent: function() as Boolean
            return m._value <> Invalid
        end function,

        isInvalid: function() as Boolean
            return m._value = Invalid
        end function
    }

    return optional

end function
