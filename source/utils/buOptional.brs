'
' A container object which may or may not contain a Invalid value or an error.
' If a value is present and there's no error, isPresent() will return true
' and get() will return the value.
' @constructor
' @example
'   ' To raise errors
'   function someFunc() as Object
'       return buOptional().error("This is an error", 500)
'   end function
'
' @param {Dynamic} [value] - the value of this optional
' @returns {Object} a new buOptional
' @license MIT
function buOptional(value = Invalid as Dynamic) as Object

    optional = {

        _value: value,
        _error: Invalid,

        ' Creates an error optional object
        ' @param {String} msg - the error message
        ' @param {Integer} [code = 0] - a unique error code. Default to 0
        ' @param {Dynamic} [data = Invalid] - container for data. Default to Invalid
        ' @returns {Object} self
        error: function(msg as String, code = 0 as Integer, data = Invalid as Dynamic) as Object
            m._error = {
                message: msg,
                code: code,
                data: data
            }
            return m
        end function

        ' Get the value of this optional
        ' @returns {Dynamic} the value stored or Invalid
        get: function() as Dynamic
            return m._value
        end function,

        ' Get the error object
        ' @returns {Dynamic} the error object or Invalid
        getError: function() as Dynamic
            return m._error
        end function,

        ' Executes the given Function if there's a value
        ' @example
        ' res = optional.ifPresent(function(value) as Integer
        '     return value + 1
        ' end function)
        ' @param {Function} func - Function to execute
        ' @returns {Dynamic} the result of the function or Invalid if there's no value or if error
        ifPresent: function(func as Function) as Dynamic
            if(m._value <> Invalid and m._error = Invalid) then
                return func(m._value)
            end if
            return Invalid
        end function,

        ' Indicates if there's a value present
        ' @returns {Boolean} true if there's a value
        isPresent: function() as Boolean
            return m._value <> Invalid and m._error = Invalid
        end function,

        ' Indicates if there's no value present
        ' @returns {Boolean} true if there's no value
        isInvalid: function() as Boolean
            return m._value = Invalid and m._error = Invalid
        end function,

        ' Indicates if this is an error
        ' @returns {Boolean} true if this is an error
        isError: function() as Boolean
            return m._value = Invalid and m._error <> Invalid
        end function
    }

    return optional

end function
