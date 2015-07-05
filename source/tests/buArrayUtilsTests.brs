function buArrayUtilsTests() as Object
    tests = {
        testEquals: function() as Void
            buTest().assertTrue(buArrayUtils().equals([1,2,3], [1,2,3]))
            buTest().assertFalse(buArrayUtils().equals([1,2,3,4], [1,2,3]))
            buTest().assertFalse(buArrayUtils().equals([1,2,2], [1,2,3]))
            buTest().assertTrue(buArrayUtils().equals(["1","2","3"], ["1","2","3"]))
            buTest().assertFalse(buArrayUtils().equals(["1","2","2"], ["1","2","3"]))
            buTest().assertFalse(buArrayUtils().equals(["1","2","3", "4"], ["1","2","3"]))
            buTest().assertTrue(buArrayUtils().equals([],[]))
            buTest().assertFalse(buArrayUtils().equals(Invalid, Invalid))
        end function,

        testIsEmpty: function() as Void
            buTest().assertTrue(buArrayUtils().isEmpty([]))
            buTest().assertTrue(buArrayUtils().isEmpty(Invalid))
            buTest().assertFalse(buArrayUtils().isEmpty([1,2,3]))
        end function,

        testContains: function() as Void
            buTest().assertTrue(buArrayUtils().contains([1,2,3], 2))
            buTest().assertFalse(buArrayUtils().contains([1,2,3], 4))
        end function,

        testIndexOf: function() as Void
            buTest().assertEquals(buArrayUtils().indexOf([1,2,3], 4), -1)
            buTest().assertEquals(buArrayUtils().indexOf([], 3), -1)
            buTest().assertEquals(buArrayUtils().indexOf([1,2,3], Invalid), -1)
            buTest().assertEquals(buArrayUtils().indexOf([1,2,3], {}), -1)
            buTest().assertEquals(buArrayUtils().indexOf([1,2,3], 3), 2)
        end function,

        testAdd: function() as Void
            expected = [1, 4, 2, 3]
            arr = buArrayUtils().add([1,2,3], 1, 4)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "Add in the middle")

            arr = buArrayUtils().add([1,4,2], 3, 3)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "Add at the end")

            arr = buArrayUtils().add([4,2,3], 0, 1)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "Add at beginning")

            arr = buArrayUtils().add([1,4,2,3], 10, 1)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "Dont add because index is bigger than count")

            arr = buArrayUtils().add([1,4,2,3], -1, 1)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "Dont add because index is less than 0")

            arr = buArrayUtils().add([], 10, 1)
            buTest().assertTrue(buArrayUtils().equals(arr, [1]), "To an empty array add the element")
        end function,

        testReplace: function() as Void
            expected = [1, 4, 3]
            arr = buArrayUtils().replace([1,2,3], 1, 4)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "Replace in middle")

            arr = buArrayUtils().replace([1,4,2], 2, 3)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "Replace at last (2)")

            arr = buArrayUtils().replace([2,4,3], 0, 1)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "Replace at 0")

            arr = buArrayUtils().replace([1,4,3], 3, 2)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "Dont replace because index is too big")

            arr = buArrayUtils().replace([1,4,3], -1, 2)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "Dont replace because index is less than 0")

            arr = buArrayUtils().replace([], 3, 2)
            buTest().assertTrue(buArrayUtils().equals(arr, []), "Dont replace because is empty")
        end function,

        testSubarray: function() as Void
            expected = [3, 4, 8]
            arr = buArrayUtils().subArray([1, 2, 3, 4, 8, 9], 2, 4)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "subArray from the middle")

            arr = buArrayUtils().subArray([3, 4, 8, 2, 5, 1], 0, 2)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "subArray from the start")

            arr = buArrayUtils().subArray([3, 4, 8, 2, 5, 1], -10, 2)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "subArray from -10 behaves like from 0")

            arr = buArrayUtils().subArray([2, 5, 1, 3, 4, 8], 3, 5)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "subArry from last elements")

            arr = buArrayUtils().subArray([2, 5, 1, 3, 4, 8], 3, 6)
            buTest().assertTrue(buArrayUtils().equals(arr, expected), "subArry from last is bigger than count")
        end function

        addSuite: function() as Void
            suite = {
                name: "buArrayUtilsTests",
                tests: [
                    { name: "testEquals", test: m.testEquals },
                    { name: "testIsEmpty", test: m.testIsEmpty },
                    { name: "testContains", test: m.testContains },
                    { name: "testIndexOf", test: m.testIndexOf },
                    { name: "testAdd", test: m.testAdd },
                    { name: "testReplace", test: m.testReplace },
                    { name: "testSubarray", test: m.testSubarray },
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
