function buSetTests() as Object
    tests = {
        testGet: function() as Void
            s = buSet([1,2,3])
            buTest().assertEquals(s.get(0), 1)
            buTest().assertInvalid(s.get(10))
        end function,

        testContains: function() as Void
            s = buSet([1,2,3])
            buTest().assertTrue(s.contains(1))
            buTest().assertFalse(s.contains(0))
        end function,

        testAdd: function() as Void
            s = buSet([1,2,3])
            buTest().assertTrue(s.add(10))
            buTest().assertFalse(s.add(1))
        end function,

        testRemove: function() as Void
            s = buSet([1,2,3])
            buTest().assertTrue(s.remove(1))
            buTest().assertEquals(s.count(), 2)
            buTest().assertFalse(s.remove(10))
            buTest().assertEquals(s.count(), 2)
        end function,

        addSuite: function() as Void
            suite = {
                name: "buSetTests",
                tests: [
                    { name: "testGet", test: m.testGet },
                    { name: "testContains", test: m.testContains },
                    { name: "testAdd", test: m.testAdd },
                    { name: "testRemove", test: m.testRemove },
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
