'
'   Initialise the application and run the tests
'
sub main(args as Dynamic)
    logger = buLogger("main")
    logger.info("brs-utils version: {0}", buDeviceUtils().getAppVersion())
    runTests()
end sub

sub runTests()
    testbuLogger()
    buTypeUtilsTests()
    buStringUtilsTests()
    buArrayUtilsTests()
    buI18NTests()
    buOptionalTests()
    buDeviceUtilsTests()
    buNumbersUtilsTests()
    buSetTests()
    buRandomUtilsTests()
    buCacheTests()
    buDateTimeUtilsTests()
    buTest().runAllTests()
end sub
