'
' Util functions to work with the device
'
' @singleton
' @returns {Object} the buDeviceUtils singleton
' @license MIT
function buDeviceUtils() as Object
    if(m.buDeviceUtils = Invalid) then
        m.buDeviceUtils = {

            ' Reads from the manifest the application version
            ' @returns {String} with the version like 0.0.1
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

            ' Get the device resolution
            ' @returns {String} HD or SD
            getResolution: function() as String
                roInfo = createObject("roDeviceInfo")
                if roInfo.getDisplayMode() = "480i" then
                    return "SD"
                else
                    return "HD"
                end if
            end function,

            ' Get the device's firmware version
            ' @returns {String} the version of the firmware
            getFirmwareVersion: function() as String
                roInfo = createObject("roDeviceInfo")
                v = roInfo.getVersion()
                major = v.mid(2, 1)
                minor = v.mid(5, 1)
                return major + "." + minor
            end function,

            ' Get the device configured language
            ' @return {String} the language converted to en-GB or en-US
            getCurrentLanguage: function() as String
                roInfo = createObject("roDeviceInfo")
                locale = roInfo.getCurrentLocale()
                return buStringUtils().replace(locale, "_", "-")
            end function,

            ' Writes an entry to the registry
            ' @param {String} key - the key of the value
            ' @param {String} value - the value
            ' @param {String} [section = "default_section"] - the section
            writeEntry: function(key as String, value as String, section = "default_section" as String) as Void
                roRegistry = createObject("roRegistrySection", section)
                roRegistry.write(key, value)
                roRegistry.flush()
            end function,

            ' Reads an entry from the registry
            ' @param {String} key - the key of the value
            ' @param {String} [section = "default_section"] - the section
            ' @returns {buOptional}
            readEntry: function(key as String, section = "default_section" as String) as Object
                roRegistry = createObject("roRegistrySection", section)

                res = Invalid

                if roRegistry.exists(key) then
                    res = roRegistry.read(key)
                end if

                return buOptional(res)
            end function,

            ' List all entries of a section from the registry
            ' @param {String} [section = "default_section"] - the section
            ' @returns {roAssociativeArray} all key values of the section
            listEntries: function(section = "default_section" as String) as Object
                roRegistry = createObject("roRegistrySection", section)
                allKeys = roRegistry.getKeyList()

                res = createObject("roAssociativeArray")
                for each key in allKeys
                    res.addReplace(key, roRegistry.read(key))
                end for

                return res
            end function,

            ' List all sections from the registry
            ' @returns {roArray} all the sections
            listSections: function() as Object
                roRegistry = createObject("roRegistry")
                return roRegistry.getSectionList()
            end function,

            ' Deletes an entry from the registry
            ' @param {String} key - the key of the value
            ' @param {String} [section = "default_section"] - the section
            deleteEntry: function(key as String, section = "default_section" as String) as Void
                roRegistry = createObject("roRegistrySection", section)

                if roRegistry.exists(key) then
                    roRegistry.delete(key)
                    roRegistry.flush()
                end if
            end function,

            ' Deletes all entries from the registry
            ' @param {String} [section = "default_section"] - the section
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
