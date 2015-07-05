function buRandomUtilsTests() as Object
    tests = {
        testAll: function() as Void
            buTest().assertFalse(buRandomUtils().nextInteger() = buRandomUtils().nextInteger())
            buTest().assertFalse(buRandomUtils().nextFloat() = buRandomUtils().nextFloat())
            buTest().assertFalse(buRandomUtils().nextString() = buRandomUtils().nextString())
            buTest().assertFalse(buRandomUtils().nextHexString() = buRandomUtils().nextHexString())
            buTest().assertFalse(buRandomUtils().uuid() = buRandomUtils().uuid())
        end function,

        addSuite: function() as Void
            suite = {
                name: "buRandomUtilsTests",
                tests: [
                    { name: "testAll", test: m.testAll },
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
