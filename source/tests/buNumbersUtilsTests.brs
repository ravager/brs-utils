function buNumbersUtilsTests() as Object
    tests = {
        testMax: function() as Void
            buTest().assertEquals(buNumbersUtils().max([1,2,4,9,2,5,1]), 9)
            buTest().assertInvalid(buNumbersUtils().max(["1","2"]))
            buTest().assertInvalid(buNumbersUtils().max([]))
        end function,

        testMin: function() as Void
            buTest().assertEquals(buNumbersUtils().min([1,2,-4,9,2,5,1]), -4)
            buTest().assertInvalid(buNumbersUtils().min(["1","2"]))
            buTest().assertInvalid(buNumbersUtils().min([]))
        end function,

        testCeiling: function() as Void
            buTest().assertEquals(buNumbersUtils().ceiling(2.1!), 3)
            buTest().assertEquals(buNumbersUtils().ceiling(2.1#), 3)
            buTest().assertEquals(buNumbersUtils().ceiling(2), 2)
            buTest().assertEquals(buNumbersUtils().ceiling("2.1"), 0)
        end function,

        testFloor: function() as Void
            buTest().assertEquals(buNumbersUtils().floor(2.1!), 2)
            buTest().assertEquals(buNumbersUtils().floor(2.1#), 2)
            buTest().assertEquals(buNumbersUtils().floor(2), 2)
            buTest().assertEquals(buNumbersUtils().floor("2.1"), 0)
        end function,

        testRound: function() as Void
            buTest().assertEquals(buNumbersUtils().round(2.1!), 2)
            buTest().assertEquals(buNumbersUtils().round(2.5!), 3)
            buTest().assertEquals(buNumbersUtils().round(2.1#), 2)
            buTest().assertEquals(buNumbersUtils().round(2.5#), 3)
            buTest().assertEquals(buNumbersUtils().round(1), 1)
        end function,

        addSuite: function() as Void
            suite = {
                name: "buNumbersUtilsTests",
                tests: [
                    { name: "testMax", test: m.testMax },
                    { name: "testMin", test: m.testMin },
                    { name: "testCeiling", test: m.testCeiling },
                    { name: "testFloor", test: m.testFloor },
                    { name: "testRound", test: m.testRound },
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
