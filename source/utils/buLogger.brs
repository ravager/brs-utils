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
'
function buLogger(root as String) as Object

    logger = {
        date:       createObject("roDateTime"),
        timer:      createObject("roTimespan"),
        root:       root,
        operation:  Invalid,
        level:      4,
        format:     "[{0}]" + chr(9) + "[{1}] [{2}]: {3}",

        setup: function() as Void
            m.date.toLocalTime()
        end function

        doLog: function(str as String, level as String, arg0 as Dynamic, arg1 as Dynamic, arg2 as Dynamic) as Void
            msg = substitute(str, buStringUtils().toStr(arg0), buStringUtils().toStr(arg1), buStringUtils().toStr(arg2))
            print substitute(m.format, m.getTimestamp(), level, m.root, msg)
        end function

        error: function(str as String, arg0 = Invalid as Dynamic, arg1 = Invalid as Dynamic, arg2 = Invalid as Dynamic) as Void
            if m.level >= 1 then
                m.doLog(str, "ERR", arg0, arg1, arg2)
            end if
        end function

        info: function(str as String, arg0 = Invalid as Dynamic, arg1 = Invalid as Dynamic, arg2 = Invalid as Dynamic) as Void
            if m.level >= 2 then
                m.doLog(str, "INF", arg0, arg1, arg2)
            end if
        end function

        test: function(str as String, arg0 = Invalid as Dynamic, arg1 = Invalid as Dynamic, arg2 = Invalid as Dynamic) as Void
            if m.level >= 3 then
                m.doLog(str, "TST", arg0, arg1, arg2)
            end if
        end function

        debug: function(str as String, arg0 = Invalid as Dynamic, arg1 = Invalid as Dynamic, arg2 = Invalid as Dynamic) as Void
            if m.level >= 4 then
                m.doLog(str, "DBG", arg0, arg1, arg2)
            end if
        end function

        start: function(op as String) as Void
            m.debug("Starting {0}", op)
            m.operation = op
            m.timer.mark()
        end function

        stop: function() as Integer
            dur = m.timer.totalMilliseconds()
            m.debug("Finished {0} in {1} milliseconds", m.operation, dur)
            return dur
        end function

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
