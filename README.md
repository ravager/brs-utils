# brs-utils
Utilities for Roku development

This includes:

* A testing framework like jUnit
* A logger inspired in Log4j
* A i18n framework for translations
* A Java like Optional implementation
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
* isNumber
* isDateTime

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
* toMD5Hash
* toSHA1Hash
* toSHA256Hash
* toSHA512Hash
* toString

## buNumbersUtils

* max
* min
* floor
* ceiling
* round

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
* writeEntry
* readEntry
* listEntries
* listSections
* deleteEntry
* deleteAllEntries

## buRandomUtils

* nextInteger
* nextFloat
* nextString
* nextHexString
* uuid

## buDateTimeUtils

* compare
* isBetween
* isAfter
* isBefore
* dateOf
* parse
* toMidnight
* duration
* addDays
* addHours
* substractDays
* substractHours

## buI18N
Retrieve translation keys from translation files. Usage:

```
buI18N().get("some.key")
buI18N().get("some.key", "1", "2", "3")
buI18N().plural("some.key", 1)
```

## buOptional
A container object which may or may not contain a non-Invalid value. If a value is
present, isPresent() will return true and get() will return the value.

## buSet
A very simplistic Set implementation. Only works with BrightScript primitives

## buCache
A Cache singleton for String data (i.e. JSON or XML data) in the Roku `tmp:` storage
