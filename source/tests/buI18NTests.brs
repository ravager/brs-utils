function buI18NTests() as Object
    tests = {
        testGet: function() as Void
            buI18N().setLanguage("es-ES")
            buTest().assertEquals(buI18N().get("test.get"), "Prueba")
            buTest().assertEquals(buI18N().get("test.empty"), "???test.empty???")
            buTest().assertEquals(buI18N().get("test.params", "1", "2", "3"), "Params 1, 2, 3")
        end function,

        testPlural: function() as Void
            buI18N().setLanguage("es-ES")
            buTest().assertEquals(buI18N().plural("test.plural", 0), "Sin contenido")
            buTest().assertEquals(buI18N().plural("test.plural", 1), "Un elemento")
            buTest().assertEquals(buI18N().plural("test.plural", 10), "10 Elementos")
        end function,

        testSetLanguage: function() as Void
            buI18N().setLanguage("es-ES")
            buTest().assertEquals(buI18N().get("test.get"), "Prueba")

            ' Test that it switched to the new language
            buI18N().setLanguage("en-US")
            buTest().assertEquals(buI18N().get("test.get"), "Testing")
        end function,

        testDefaultLanguage: function() as Void
            buI18N().setLanguage("kk-KK")
            buTest().assertEquals(buI18N().get("test.get"), "Testing")
        end function,

        addSuite: function() as Void
            suite = {
                name: "buI18NTests",
                tests: [
                    { name: "testGet", test: m.testGet },
                    { name: "testPlural", test: m.testPlural },
                    { name: "testSetLanguage", test: m.testSetLanguage },
                    { name: "testDefaultLanguage", test: m.testDefaultLanguage },
                ]
            }

            buTest().addTestSuite(suite)
        end function
    }
    tests.addSuite()
    return tests
end function
