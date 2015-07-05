'
' Retrieve translation keys from translation file.
' Usage:
'   buI18N().get("some.key");
'   buI18N().get("some.key", "1", "2", "3");
'   buI18N().plural("some.key", 1);
'
' Each translation file is to be saved under its own folder.
' For example, for English we would create the i18n/en-GB folder and place a translations.json
' file in there.
'
' JSON format is the same used by Goggle Chrome extensions, more information:
' https://developer.chrome.com/webstore/i18n#details
'/
function buI18N() as Object
    if(m.i18n = Invalid) then
        m.i18n = {

            path:           "pkg:/i18n/{0}/translations.json",
            logger:         buLogger("buI18N"),
            translations:   Invalid,
            defLanguage:    "en-US",
            language:       Invalid,

            loadTranslations: function() as Void
                if(m.language = Invalid) then
                    m.language = buDeviceUtils().getCurrentLanguage()
                end if

                m.logger.debug("Loading translations for language {0}", m.language)
                filePath = substitute(m.path, m.language)

                roFileSystem = createObject("roFileSystem")
                if(roFileSystem.exists(filePath) = false) then
                    m.logger.debug("Failed to load translations. {0} doesn't exists", filePath)
                    m.loadDefault()
                    return
                endif

                jsonData = readASCIIFile(filePath)
                m.translations = parseJSON(jsonData)

                if(buTypeUtils().isString(m.translations) and buStringUtils().isEmpty(m.translations)) then
                    m.logger.debug("Failed to load translations at {0}", filePath)
                    m.loadDefault()
                    return
                end if

            end function,

            loadDefault: function() as Void
                m.logger.debug("Loading default translations {0}", m.defLanguage)
                filePath = substitute(m.path, m.defLanguage)
                jsonData = readASCIIFile(filePath)
                m.translations = parseJSON(jsonData)

                if(buTypeUtils().isString(m.translations) and buStringUtils().isEmpty(m.translations)) then
                    m.logger.debug("Failed to load default translations at {0}", filePath)
                    m.logger.debug("Not using any translations file")
                    ' If we don't this, we'll keep trying to load the files
                    m.translations = {}
                else
                    m.language = m.defLanguage
                end if
            end function,

            get: function(key as String, a = "" as String, b = "" as String, c = "" as String) as String
                if(m.translations = Invalid) then
                    m.loadTranslations()
                end if

                translation = m.translations.lookup(key)

                if(translation = Invalid) then
                    return "???" + key + "???"
                end if

                if(buStringUtils().isEmpty(translation.message)) then
                    return "???" + key + "???"
                end if

                return substitute(translation.message, a, b, c)
            end function,

            plural: function(key as String, items as Integer) as String
                if(items = 0) then
                    key = key + ".zero"
                else if (items = 1) then
                    key = key + ".singular"
                else
                    key = key + ".plural"
                end if

                return m.get(key, buStringUtils().toString(items))
            end function,

            setLanguage: function(lang as String) as Void
                m.language = lang
                m.loadTranslations()
            end function

        }
    end if

    return m.i18n
end function
