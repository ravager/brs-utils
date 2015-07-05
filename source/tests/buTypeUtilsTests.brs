function buTypeUtilsTests() as Object
    tests = {
        testIsString: function() as Void
            buTest().assertTrue(buTypeUtils().isString("A String"))
            buTest().assertTrue(buTypeUtils().isString(""))
            buTest().assertFalse(buTypeUtils().isString(Invalid))
            buTest().assertFalse(buTypeUtils().isString(1))
            buTest().assertFalse(buTypeUtils().isString(true))
            buTest().assertFalse(buTypeUtils().isString(1.2))
        end function,

        testIsInt: function() as Void
            buTest().assertTrue(buTypeUtils().isInt(1))
            buTest().assertTrue(buTypeUtils().isInt(0))
            buTest().assertTrue(buTypeUtils().isInt(-1))
            buTest().assertFalse(buTypeUtils().isInt(Invalid))
            buTest().assertFalse(buTypeUtils().isInt("0"))
            buTest().assertFalse(buTypeUtils().isInt(true))
            buTest().assertFalse(buTypeUtils().isInt(1.2))
        end function,

        testIsBool: function() as Void
            buTest().assertTrue(buTypeUtils().isBool(true))
            buTest().assertTrue(buTypeUtils().isBool(false))
            buTest().assertFalse(buTypeUtils().isBool(Invalid))
            buTest().assertFalse(buTypeUtils().isBool("true"))
            buTest().assertFalse(buTypeUtils().isBool(1))
            buTest().assertFalse(buTypeUtils().isBool(1.2))
        end function,

        testIsFloat: function() as Void
            buTest().assertTrue(buTypeUtils().isFloat(1.2!))
            buTest().assertFalse(buTypeUtils().isFloat("1.2"))
            buTest().assertFalse(buTypeUtils().isFloat(Invalid))
            buTest().assertFalse(buTypeUtils().isFloat(true))
            buTest().assertFalse(buTypeUtils().isFloat(1))
        end function,

        testIsDouble: function() as Void
            buTest().assertTrue(buTypeUtils().isDouble(1.2#))
            buTest().assertFalse(buTypeUtils().isDouble("1.2"))
            buTest().assertFalse(buTypeUtils().isDouble(Invalid))
            buTest().assertFalse(buTypeUtils().isDouble(true))
            buTest().assertFalse(buTypeUtils().isDouble(1))
        end function,

        testIsArray: function() as Void
            buTest().assertTrue(buTypeUtils().isArray([1,2,3]))
            buTest().assertTrue(buTypeUtils().isArray([]))
            buTest().assertFalse(buTypeUtils().isArray(Invalid))
        end function,

        testIsList: function() as Void
            list = createObject("roList")
            buTest().assertTrue(buTypeUtils().isList(list))
            buTest().assertFalse(buTypeUtils().isList(Invalid))
        end function,


        testIsComparable: function() as Void
            buTest().assertTrue(buTypeUtils().isComparable(1))
            buTest().assertTrue(buTypeUtils().isComparable("1"))
            buTest().assertTrue(buTypeUtils().isComparable(true))
            buTest().assertTrue(buTypeUtils().isComparable(1.1!))
            buTest().assertTrue(buTypeUtils().isComparable(1.1#))
            buTest().assertTrue(buTypeUtils().isComparable(Invalid))
            buTest().assertFalse(buTypeUtils().isComparable([1,2,3]))
            buTest().assertFalse(buTypeUtils().isComparable({}))
        end function,

        testIsNumber: function() as Void
            buTest().assertTrue(buTypeUtils().isNumber(1))
            buTest().assertTrue(buTypeUtils().isNumber(1.1!))
            buTest().assertTrue(buTypeUtils().isNumber(1.1#))
            buTest().assertFalse(buTypeUtils().isNumber("1"))
            buTest().assertFalse(buTypeUtils().isNumber(true))
            buTest().assertFalse(buTypeUtils().isNumber(Invalid))
            buTest().assertFalse(buTypeUtils().isNumber([1,2,3]))
            buTest().assertFalse(buTypeUtils().isNumber({}))
        end function,

        testIsDateTime: function() as Void
            buTest().assertTrue(buTypeUtils().isDateTime(createObject("roDateTime")))
            buTest().assertFalse(buTypeUtils().isDateTime("1.2"))
            buTest().assertFalse(buTypeUtils().isDateTime(Invalid))
            buTest().assertFalse(buTypeUtils().isDateTime(true))
            buTest().assertFalse(buTypeUtils().isDateTime(1))
        end function,

        addSuite: function() as Void
            suite = {
                name: "buTypeUtilsTests",
                tests: [
                    { name: "testIsString", test: m.testIsString },
                    { name: "testIsInt", test: m.testIsInt },
                    { name: "testIsBool", test: m.testIsBool },
                    { name: "testIsFloat", test: m.testIsFloat },
                    { name: "testIsDouble", test: m.testIsDouble },
                    { name: "testIsArray", test: m.testIsArray },
                    { name: "testIsList", test: m.testIsList },
                    { name: "testIsComparable", test: m.testIsComparable },
                    { name: "testIsNumber", test: m.testIsNumber },
                    { name: "testIsDateTime", test: m.testIsDateTime }
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
