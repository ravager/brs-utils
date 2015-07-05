# brs-utils
Utilities for Roku development

This includes:

* A testing framework like jUnit
* A logger inspired in Log4j
* A i18n framework for translations
* An example channel with all the different templates and a video player

## buTypeUtils

* isString
* isBool
* isInt
* isArray
* isList
* isFloat
* isDouble
* isComparable

## buStringUtils

* isEmpty
* intToString
* doubleToString
* floatToString
* toStr
* equals
* truncate
* capitalize
* split
* contains
* indexOf
* lastIndexOf
* join
* toArray
* reverse
* replace
* toString

## buArrayUtils

* equals
* isEmpty
* contains
* indexOf
* add
* replace
* subArray
* toString

## buDeviceUtils

* getAppVersion
* getResolution
* getFirmwareVersion
* getCurrentLanguage

## buI18N
Retrieve translation keys from translation files. Usage:

```
buI18N().get("some.key")
buI18N().get("some.key", "1", "2", "3")
buI18N().plural("some.key", 1)
```
