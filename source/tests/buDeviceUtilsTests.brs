function buDeviceUtilsTests() as Object
    tests = {
        testRegistryUtils: function() as Void
            optional = buDeviceUtils().readEntry("foo")
            buTest().assertFalse(optional.isPresent())

            buDeviceUtils().writeEntry("foo", "FOO")
            optional = buDeviceUtils().readEntry("foo")
            buTest().assertTrue(optional.isPresent())
            buTest().assertEquals(optional.get(), "FOO")

            buDeviceUtils().deleteEntry("foo")
            optional = buDeviceUtils().readEntry("foo")
            buTest().assertFalse(optional.isPresent())
        end function,

        testDeleteAllEntries: function() as Void
            buDeviceUtils().writeEntry("foo", "FOO")
            buDeviceUtils().writeEntry("bar", "BAR")
            optional = buDeviceUtils().readEntry("bar")
            buTest().assertTrue(optional.isPresent())

            buDeviceUtils().deleteAllEntries()
            optional = buDeviceUtils().readEntry("foo")
            buTest().assertFalse(optional.isPresent())
            optional = buDeviceUtils().readEntry("bar")
            buTest().assertFalse(optional.isPresent())
        end function,

        testListEntries: function() as Void
            buDeviceUtils().writeEntry("foo", "FOO")
            buDeviceUtils().writeEntry("bar", "BAR")
            buDeviceUtils().listEntries()
            buDeviceUtils().deleteAllEntries()
        end function,

        testListSections: function() as Void
            buDeviceUtils().writeEntry("foo", "FOO")
            buDeviceUtils().listSections()
            buDeviceUtils().deleteAllEntries()
        end function,

        testInfoUtils: function() as Void
            logger = buLogger("buDeviceUtilsTests")
            logger.test("brs-utils version: {0}", buDeviceUtils().getAppVersion())
            logger.test("Firmware version: {0}", buDeviceUtils().getFirmwareVersion())
        end function,

        addSuite: function() as Void
            suite = {
                name: "buDeviceUtilsTests",
                tests: [
                    { name: "testRegistryUtils", test: m.testRegistryUtils },
                    { name: "testDeleteAllEntries", test: m.testDeleteAllEntries },
                    { name: "testListEntries", test: m.testListEntries },
                    { name: "testListSections", test: m.testListSections },
                    { name: "testInfoUtils", test: m.testInfoUtils },
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
