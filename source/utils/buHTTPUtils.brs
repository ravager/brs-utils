'
' Set of utils to work with the HTTP protocol
' @singleton
' @returns {Object} the buHTTPUtils singleton
' @license MIT
function buHTTPUtils() as Object
    if(m.buHTTPUtils = Invalid) then
        m.buHTTPUtils = {

            ' Convert an object to x-www-form-urlencoded
            ' @param {Object} obj - the object to convert
            ' @returns {buOptional} buOptional with the converted string
            objectToPOSTData: function(obj as Object) as Object
                result = []
                for each key in obj
                    result.push(key + "=" + obj[key])
                end for
                return buOptional(buStringUtils().join(result, "&"))
            end function

        }
    end if

    return m.buHTTPUtils
end function
