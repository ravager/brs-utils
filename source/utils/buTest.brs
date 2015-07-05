'
' Testing framework for Roku
'
function buTest() as Object
    if(m.buTest = Invalid) then
        m.buTest = {
            testCases: createObject("roList"),
            logger: buLogger("buTest"),
            fails: 0,

            assert: function(condition as Boolean, message as String) as Void
                if(not condition) then
                    m.fails = m.fails + 1
                    m.logger.test(message)
                end if
            end function,

            assertTrue: function(condition as Boolean, message = Invalid as Dynamic) as Void
                if(message = Invalid) then
                    message = "assertTrue failed"
                end if
                m.assert(condition, message)
            end function,

            assertFalse: function(condition as Boolean, message = Invalid as Dynamic) as Void
                if(message = Invalid) then
                    message = "assertFalse failed"
                end if
                m.assert(not condition, message)
            end function,

            assertInvalid: function(value as Dynamic, message = Invalid as Dynamic) as Void
                if(message = Invalid) then
                    message = "assertInvalid failed"
                end if
                m.assert((value = Invalid), message)
            end function,

            assertNotInvalid: function(value as Dynamic, message = Invalid as Dynamic) as Void
                if(message = Invalid) then
                    message = "assertNotInvalid failed"
                end if
                m.assert((value <> Invalid), message)
            end function,

            assertEquals: function(value as Dynamic, expected as Dynamic, message = Invalid as Dynamic) as Void
                if(message = Invalid) then
                    message = "assertEquals failed: " + buStringUtils().toString(value) + " is not " + buStringUtils().toString(expected)
                end if
                m.assert((value = expected), message)
            end function,

            addTestCase: function(suiteName as String, testName as String, test as Function) as Void
                m.testCases.addTail({suite: suiteName, name: testName, func: test})
            end function,

            addTestSuite: function(suite as Object) as Void
                for each testCase in suite.tests
                    m.addTestCase(suite.name, testCase.name, testCase.test)
                end for
            end function,

            runAllTests: function() as Boolean
                for each test in m.testCases
                    m.logger.test("Running {0}.{1}", test.suite, test.name)
                    test.func()
                end for

                if(m.fails <> 0) then
                    m.logger.error("Failed {0} tests", m.fails)
                else
                    m.logger.info("Success. All tests passed")
                endif

                return true
            end function
        }
    end if

    return m.buTest

end function
