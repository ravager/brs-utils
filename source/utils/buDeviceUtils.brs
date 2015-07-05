'
' Util functions to work with the device
'
function buDeviceUtils() as Object
    if(m.buDeviceUtils = Invalid) then
        m.buDeviceUtils = {
            getAppVersion: function() as String
                majorVsersion = "0"
                minorVersion = "0"
                buildVersion = "0"

                file = readASCIIFile("pkg:/manifest")
                rows = file.tokenize(chr(10))

                for each row in rows
                    row = row.trim()

                    if len(row) > 0 then
                        keyValue = row.tokenize("=")

                        if keyValue.count() > 1 then
                            key = keyValue[0]
                            value = keyValue[1]

                            if key = "major_version" then
                                majorVersion = value
                            else if key = "minor_version" then
                                minorVersion = value
                            else if key = "build_version" then
                                buildVersion = value
                            end if
                        end if
                    end if
                end for
                return majorVersion + "." + minorVersion + "." + buildVersion
            end function,

            getResolution: function() as String
                roInfo = createObject("roDeviceInfo")
                if roInfo.getDisplayMode() = "480i" then
                    return "SD"
                else
                    return "HD"
                end if
            end function,

            getFirmwareVersion: function() as String
                roInfo = createObject("roDeviceInfo")
                v = roInfo.getVersion()
                major = v.mid(2, 1)
                minor = v.mid(5, 1)
                return major + "." + minor
            end function,

            getCurrentLanguage: function() as String
                roInfo = createObject("roDeviceInfo")
                locale = roInfo.getCurrentLocale()
                return buStringUtils().replace(locale, "_", "-")
            end function,

            writeEntry: function(key as String, value as String, section = "default_section" as String) as Void
                roRegistry = createObject("roRegistrySection", section)
                roRegistry.write(key, value)
                roRegistry.flush()
            end function,

            readEntry: function(key as String, section = "default_section" as String) as Object
                roRegistry = createObject("roRegistrySection", section)

                res = Invalid

                if roRegistry.exists(key) then
                    res = roRegistry.read(key)
                end if

                return buOptional(res)
            end function,

            listEntries: function(section = "default_section" as String) as Object
                roRegistry = createObject("roRegistrySection", section)
                allKeys = roRegistry.getKeyList()

                res = createObject("roAssociativeArray")
                for each key in allKeys
                    res.addReplace(key, roRegistry.read(key))
                end for

                return res
            end function,

            listSections: function() as Object
                roRegistry = createObject("roRegistry")
                return roRegistry.getSectionList()
            end function,

            deleteEntry: function(key as String, section = "default_section" as String) as Void
                roRegistry = createObject("roRegistrySection", section)

                if roRegistry.exists(key) then
                    roRegistry.delete(key)
                    roRegistry.flush()
                end if
            end function,

            deleteAllEntries: function(section = "default_section" as String) as Void
                roRegistry = createObject("roRegistrySection", section)

                allKeys = roRegistry.getKeyList()
                allKeys.resetIndex()
                key = allKeys.getIndex()

                while key <> Invalid
                    roRegistry.delete(key)
                    roRegistry.flush()
                    key = allKeys.getIndex()
                end while
            end function
        }
    end if
    return m.buDeviceUtils
end function
