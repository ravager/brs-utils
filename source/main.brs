'
'   Initialise the application and run the tests
'
sub main(args as Dynamic)
    logger = buLogger("main")

    runTests()

    logger.info("brs-utils version: {0}", buDeviceUtils().getAppVersion())
    logger.info("Firmware version: {0}", buDeviceUtils().getFirmwareVersion())
end sub

sub runTests()
    testbuLogger()
    buTypeUtilsTests()
    buStringUtilsTests()
    buArrayUtilsTests()
    buI18NTests()
    buTest().runAllTests()
end sub
