function buStringUtilsTests() as Object
    tests = {
        testIsEmpty: function() as Void
            buTest().assertTrue(buStringUtils().isEmpty(""))
            buTest().assertTrue(buStringUtils().isEmpty(" "))
            buTest().assertFalse(buStringUtils().isEmpty("f"))
            buTest().assertFalse(buStringUtils().isEmpty("f00"))
        end function,

        testIntToString: function() as Void
            buTest().assertEquals(buStringUtils().intToString(1), "1")
        end function,

        testDoubleToString: function() as Void
            buTest().assertEquals(buStringUtils().doubleToString(1.2#), "1.2")
        end function,

        testToString: function() as Void
            buTest().assertEquals(buStringUtils().toString(1), "1")
            buTest().assertEquals(buStringUtils().toString("1"), "1")
            buTest().assertEquals(buStringUtils().toString(1.2#), "1.2")
            buTest().assertEquals(buStringUtils().toString(1.2!), "1.2")
            buTest().assertEquals(buStringUtils().toString(true), "true")
            buTest().assertEquals(buStringUtils().toString(Invalid), "Invalid")
            buTest().assertEquals(buStringUtils().toString({}), "roAssociativeArray")
            buTest().assertEquals(buStringUtils().toString([1,2,3]), "[1,2,3]")
        end function,

        testEquals: function() as Void
            buTest().assertTrue(buStringUtils().equals(1, 1))
            buTest().assertTrue(buStringUtils().equals("1", "1"))
            buTest().assertTrue(buStringUtils().equals(Invalid, Invalid))
            buTest().assertTrue(buStringUtils().equals(Invalid, "Invalid"))
            buTest().assertFalse(buStringUtils().equals("true", "false"))
            buTest().assertFalse(buStringUtils().equals("1", "0"))
        end function,

        testTruncate: function() as Void
            buTest().assertEquals(buStringUtils().truncate("LoremIpsum", 3), "Lor...")
            buTest().assertEquals(buStringUtils().truncate("LoremIpsum", 0), "...")
            buTest().assertEquals(buStringUtils().truncate("LoremIpsum", 10), "LoremIpsum")
        end function,

        testCapitalize: function() as Void
            buTest().assertEquals(buStringUtils().capitalize("LoremIpsum"), "Loremipsum")
            buTest().assertEquals(buStringUtils().capitalize("Loremipsum"), "Loremipsum")
            buTest().assertEquals(buStringUtils().capitalize("LOREMIPSUM"), "Loremipsum")
        end function,

        testSplit: function() as Void
            splitted = buStringUtils().split("Lorem,Ipsum", ",")
            buTest().assertEquals(splitted[0], "Lorem")
            buTest().assertEquals(splitted[1], "Ipsum")
        end function,

        testContains: function() as Void
            buTest().assertTrue(buStringUtils().contains("Lorem, Ipsum", ","))
            buTest().assertFalse(buStringUtils().contains("Lorem, Ipsum", "/."))
        end function,

        testIndexOf: function() as Void
            buTest().assertEquals(buStringUtils().indexOf("Lorem, Ipsum", ","), 5)
            buTest().assertEquals(buStringUtils().indexOf("Lorem, Ipsum", "/."), -1)
        end function,

        testLastIndexOf: function() as Void
            buTest().assertEquals(buStringUtils().lastIndexOf("Lorem, Ipsum, Lorem Sonet", ","), 13)
            buTest().assertEquals(buStringUtils().lastIndexOf("Lorem, Ipsum, Lorem, Sonet", ","), 20)
            buTest().assertEquals(buStringUtils().lastIndexOf("Lorem, Ipsum, Lorem, Sonet", "/."), -1)
        end function,

        testJoin: function() as Void
            buTest().assertEquals(buStringUtils().join(["Lor", "em"]), "Lorem")
            buTest().assertEquals(buStringUtils().join(["Lor", "em", 1]), "Lorem1")
            buTest().assertEquals(buStringUtils().join(["Lor", "em", 1, true]), "Lorem1true")
            buTest().assertEquals(buStringUtils().join([1,2,3]), "123")
            buTest().assertEquals(buStringUtils().join([1,2,3], ","), "1,2,3")
        end function,

        testToArray: function() as Void
            res = buStringUtils().toArray("Lorem")
            expected = ["L","o","r","e","m"]
            buTest().assertTrue(buArrayUtils().equals(res, expected))
        end function,

        testReverse: function() as Void
            buTest().assertEquals(buStringUtils().reverse("Lorem"), "meroL")
            buTest().assertEquals(buStringUtils().reverse(""), "")
        end function,

        addSuite: function() as Void
            suite = {
                name: "buStringUtilsTests",
                tests: [
                    { name: "testIsEmpty", test: m.testIsEmpty },
                    { name: "testIntToString", test: m.testIntToString },
                    { name: "testDoubleToString", test: m.testDoubleToString },
                    { name: "testToString", test: m.testToString },
                    { name: "testEquals", test: m.testEquals },
                    { name: "testTruncate", test: m.testTruncate },
                    { name: "testCapitalize", test: m.testCapitalize },
                    { name: "testSplit", test: m.testSplit },
                    { name: "testContains", test: m.testContains },
                    { name: "testIndexOf", test: m.testIndexOf },
                    { name: "testLastIndexOf", test: m.testLastIndexOf },
                    { name: "testJoin", test: m.testJoin },
                    { name: "testToArray", test: m.testToArray },
                    { name: "testReverse", test: m.testReverse }
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
