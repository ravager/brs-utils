function buCacheTests() as Object
    tests = {
        testCache: function() as Void
            key = buRandomUtils().nextString(10)
            value = buRandomUtils().nextString(20)
            buCache().add(key, value, 1)
            buTest().assertEquals(buCache().get(key), value)
            sleep(2000)
            buTest().assertInvalid(buCache().get(key))
        end function,

        addSuite: function() as Void
            suite = {
                name: "buCacheTests",
                tests: [
                    { name: "testCache", test: m.testCache },
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
