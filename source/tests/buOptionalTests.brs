function buOptionalTests() as Object
    tests = {
        testOptional: function() as Void
            optional = buOptional(1)
            buTest().assertNotInvalid(optional.get())
            buTest().assertTrue(optional.isPresent())
            buTest().assertFalse(optional.isInvalid())
            buTest().assertFalse(optional.isError())

            res = optional.ifPresent(function(value) as Integer
                return value + 1
            end function)

            buTest().assertEquals(res, 2)
        end function,

        testInvalidOptional: function() as Void
            optional = buOptional()
            buTest().assertInvalid(optional.get())
            buTest().assertFalse(optional.isPresent())
            buTest().assertTrue(optional.isInvalid())
            buTest().assertFalse(optional.isError())

            res = optional.ifPresent(function(value) as Integer
                return value + 1
            end function)

            buTest().assertInvalid(res)
        end function,

        testErrorOptional: function() as Void
            optional = buOptional().error("This is an error")
            buTest().assertInvalid(optional.get())
            buTest().assertFalse(optional.isPresent())
            buTest().assertFalse(optional.isInvalid())
            buTest().assertTrue(optional.isError())

            res = optional.ifPresent(function(value) as Integer
                return value + 1
            end function)

            buTest().assertInvalid(res)
            buTest().assertEquals(optional.getError().message, "This is an error")
        end function,

        addSuite: function() as Void
            suite = {
                name: "buOptionalTests",
                tests: [
                    { name: "testOptional", test: m.testOptional },
                    { name: "testInvalidOptional", test: m.testInvalidOptional },
                    { name: "testErrorOptional", test: m.testErrorOptional }
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
