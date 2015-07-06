' Implementation of a logger. This logger is not a singleton, so each
' caller owns a reference to it and should be GC when not needed.
' Normal Usage:
'    logger = buLogger("testLogger")
'    logger.info("Single Message")
'    logger.info("Message with {0} param", 1)
'    logger.error("Message with {0} params: {1}", 2, "test")
'    logger.debug("Message with {0} params: {1} & {2}", 3, "test", true)
'
' Performance / Timer usage:
'    logger = buLogger("testLogger")
'    logger.start("Connecting with example.com")
'    longRunningOperation()
'    logger.stop()
'
' Levels:
'    0 = OFF
'    1 = Errors
'    2 = Errors & info
'    3 = Errors & info & test
'    4 = All
'
' @returns {buLogger} a new buLogger
' @license MIT
function buLogger(root as String) as Object

    logger = {
        date:       createObject("roDateTime"),
        timer:      createObject("roTimespan"),
        root:       root,
        operation:  Invalid,
        level:      4,
        format:     "[{0}]" + chr(9) + "[{1}] [{2}]: {3}",

        ' Setup the logger
        ' @private
        setup: function() as Void
            m.date.toLocalTime()
        end function

        ' Generates the log output
        ' @private
        ' @param {String} str - the message to print
        ' @param {String} arg0 - the {0} value to replace
        ' @param {String} arg1 - the {1} value to replace
        ' @param {String} arg2 - the {2} value to replace
        doLog: function(str as String, level as String, arg0 as Dynamic, arg1 as Dynamic, arg2 as Dynamic) as Void
            msg = substitute(str, buStringUtils().toStr(arg0), buStringUtils().toStr(arg1), buStringUtils().toStr(arg2))
            print substitute(m.format, m.getTimestamp(), level, m.root, msg)
        end function

        ' Prints an error log message
        ' @param {String} str - the message to print
        ' @param {Dynamic} [arg0 = Invalid] - the {0} value to replace
        ' @param {Dynamic} [arg1 = Invalid] - the {1} value to replace
        ' @param {Dynamic} [arg2 = Invalid] - the {2} value to replace
        error: function(str as String, arg0 = Invalid as Dynamic, arg1 = Invalid as Dynamic, arg2 = Invalid as Dynamic) as Void
            if m.level >= 1 then
                m.doLog(str, "ERR", arg0, arg1, arg2)
            end if
        end function

        ' Prints an info log message
        ' @param {String} str - the message to print
        ' @param {Dynamic} [arg0 = Invalid] - the {0} value to replace
        ' @param {Dynamic} [arg1 = Invalid] - the {1} value to replace
        ' @param {Dynamic} [arg2 = Invalid] - the {2} value to replace
        info: function(str as String, arg0 = Invalid as Dynamic, arg1 = Invalid as Dynamic, arg2 = Invalid as Dynamic) as Void
            if m.level >= 2 then
                m.doLog(str, "INF", arg0, arg1, arg2)
            end if
        end function

        ' Prints a test log message
        ' @param {String} str - the message to print
        ' @param {Dynamic} [arg0 = Invalid] - the {0} value to replace
        ' @param {Dynamic} [arg1 = Invalid] - the {1} value to replace
        ' @param {Dynamic} [arg2 = Invalid] - the {2} value to replace
        test: function(str as String, arg0 = Invalid as Dynamic, arg1 = Invalid as Dynamic, arg2 = Invalid as Dynamic) as Void
            if m.level >= 3 then
                m.doLog(str, "TST", arg0, arg1, arg2)
            end if
        end function

        ' Prints a debug log message
        ' @param {String} str - the message to print
        ' @param {Dynamic} [arg0 = Invalid] - the {0} value to replace
        ' @param {Dynamic} [arg1 = Invalid] - the {1} value to replace
        ' @param {Dynamic} [arg2 = Invalid] - the {2} value to replace
        debug: function(str as String, arg0 = Invalid as Dynamic, arg1 = Invalid as Dynamic, arg2 = Invalid as Dynamic) as Void
            if m.level >= 4 then
                m.doLog(str, "DBG", arg0, arg1, arg2)
            end if
        end function

        ' Starts to count the timer for the given operation
        ' @param {String} op - the operation that starts
        start: function(op as String) as Void
            m.debug("Starting {0}", op)
            m.operation = op
            m.timer.mark()
        end function

        ' Stops the counter and logs the duration the operation took in milliseconds
        stop: function() as Integer
            dur = m.timer.totalMilliseconds()
            m.debug("Finished {0} in {1} milliseconds", m.operation, dur)
            return dur
        end function

        ' Get the timestamp fot the logger
        ' @private
        ' @returns {String} the timestamp
        getTimestamp: function() as String
            m.date.mark()
            timeStamp = m.date.asDateString("short-date-dashes")
            timeStamp = timeStamp + " " + m.date.getHours().toStr()
            timeStamp = timeStamp + ":" + m.date.getMinutes().toStr()
            timeStamp = timeStamp + ":" + m.date.getSeconds().toStr()
            timeStamp = timeStamp + "." + m.date.getMilliseconds().toStr()
            return timeStamp
        end function
    }

    logger.setup()
    return logger

end function

sub testbuLogger()
    logger = buLogger("testLogger")
    logger.info("Single Message")
    logger.info("Message with {0} param", 1)
    logger.error("Message with {0} params: {1}", 2, "test")
    sleep(100)
    logger.debug("Message with {0} params: {1} & {2}", 3, "test", true)
    logger.debug("Message with {0} params: {1} & {2}", 3, "test", Invalid)

    logger.start("Timer")
    sleep(100)
    logger.stop()
end sub
