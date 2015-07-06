'
' Utils to work with dates and times
' @singleton
' @returns {Object} the buArrayUtils singleton
' @license MIT
function buDateTimeUtils() as Object
    if(m.buDateTimeUtils = Invalid) then
        m.buDateTimeUtils = {

            ' Compares two roDateTimes
            ' @param {roDateTime} date1 - the first roDateTime to compare
            ' @param {roDateTime} date2 - the second roDateTime to compare
            ' @returns {Integer} 1 if date1 > date2. 0 if they are the same. -1 if date1 < date2.
            compare: function(date1 as Object, date2 as Object) as Integer
                sd1 = date1.asSeconds()
                sd2 = date2.asSeconds()

                if sd1 < sd2 then
                    return -1
                else if sd1 > sd2 then
                    return 1
                else
                    return 0
                end if
            end function,

            ' Compares three dates to know if it's between them
            ' @param {Object} startDateTime - when the range starts
            ' @param {Object} between - the roDateTime we want to check
            ' @param {Object} endDateTime - when the range ends
            ' @return {Boolean} true if the roDateTime between is between the other two.
            isBetween: function(startDateTime as Object, between as Object, endDateTime as Object) as Boolean
                return m.compare(between, startDateTime) > 0 and m.compare(between, endDateTime) < 0
            end function,

            ' Compares two dates to know if before is before current
            ' @param {Object} current - when the range starts
            ' @param {Object} before - the roDateTime we want to check
            ' @return {Boolean} true if the roDateTime between is before
            isBefore: function(current as Object, before as Object) as Boolean
                return m.compare(current, before) < 0
            end function,

            ' Compares two dates to know if after is before current
            ' @param {Object} current - when the range starts
            ' @param {Object} after - the roDateTime we want to check
            ' @returns {Boolean} true if the roDateTime between is after
            isAfter: function(current as Object, after as Object) as Boolean
                return m.compare(current, after) > 0
            end function,

            dateOf: function(year as Integer, month as Integer, day as Integer, hour = 0 as Integer, minutes = 0 as Integer) as Object
                hourStr = hour.toStr()
                if hour < 10 then
                    hourStr = "0" + hourStr
                end if

                minuteStr = minutes.toStr()
                if minutes < 10 then
                    minuteStr = "0" + minuteStr
                end if

                _date = createObject("roDateTime")
                _date.fromISO8601String(year.toStr() + "-" + month.toStr() + "-" + day.toStr() + " " + hourStr + ":" + minuteStr + ":00")
                return _date
            end function,

            ' Parse this 2016/11/03 to a roDateTime or this
            ' @param {String} d - String like 2016/11/03
            ' @param {String} t - Optional string like 01:02
            ' @returns {roDateTime}
            parse: function(d as String, t = "00:00" as String) as Object
                if d = Invalid then
                    return Invalid
                end if

                ' Tokenize from YYYY/MM/DD
                dateTokens = d.tokenize("/")

                if dateTokens.count() <> 3 then
                    return Invalid
                end if

                ' Now, roDateTime only likes ISO format
                ' YYYY-MM-DD HH:MM:SS
                date = createObject("roDateTime")
                date.fromISO8601String(dateTokens[0] + "-" + dateTokens[1] + "-" + dateTokens[2] + " " + t)

                return date
            end function,

            toMidnight: function(date as Object) as Object
                y = date.getYear()
                m = date.getMonth()
                d = date.getDayOfMonth()
                return buDateTimeUtils().dateOf(y, m, d, 23, 59)
            end function,

            ' Calculate time duration in seconds
            ' @param {Object} starts - when the duration starts
            ' @param {Object} ends - when the duration ends
            ' @returns {Integer} seconds between the two dates
            duration: function(starts as Object, ends as Object) as Integer
                if starts = Invalid or ends = Invalid then
                    return 0
                end if

                startSeconds = starts.asSeconds()
                endSeconds = ends.asSeconds()

                return endSeconds - startSeconds
            end function,

            ' Add days to a roDateTime
            ' @param {Object} date - the date to modify
            ' @param {Integer} days - days to add
            ' @returns {roDateTime} the new date
            addDays: function(date as Object, days as Integer) as Object
                if days <= 0 then
                    return date
                end if

                return m.addHours(date, (days * 24))
            end function,

            ' Remove days from a roDateTime
            ' @param {Object} date - the date to modify
            ' @param {Integer} days - days to substract
            ' @returns {roDateTime} the new date
            substractDays: function(date as Object, days as Integer) as Object
                if days <= 0 then
                    return date
                end if

                return m.substractHours(date, (days * 24))
            end function,

            ' Add hours to a roDateTime
            ' @param {Object} date - the date to modify
            ' @param {Integer} hours - hours to add
            ' @returns {roDateTime} the new date
            addHours: function(date as Object, hours as Integer) as Object
                if hours <= 0 then
                    return date
                end if

                seconds = hours * 60 * 60
                newDate = createObject("roDateTime")
                newDate.fromSeconds(date.asSeconds() + seconds)
                return newDate
            end function,

            ' Remove hours from a roDateTime
            ' @param {Object} date - the date to modify
            ' @param {Integer} hours - hours to substract
            ' @returns {roDateTime} the new date
            substractHours: function(date as Object, hours as Integer) as Object
                if hours <= 0 then
                    return date
                end if

                seconds = hours * 60 * 60
                newDate = createObject("roDateTime")
                newDate.fromSeconds(date.asSeconds() - seconds)
                return newDate
            end function
        }
    endif
    return m.buDateTimeUtils
end function
