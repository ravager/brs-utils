'
' A Cache singleton for String data (i.e. JSON or XML data). For usage check the test bellow.
' We can store any data since the cache stores this data in the Roku
' /tmp folder and only keeps in memory a reference for this data in an array.
' This reference array has a maximum size of maxSize elements.
' Take into account that this folder is deleted each time the application quits.
'
function getCache() as Object

    if m.cache = Invalid then
        ' first time we run, create the cache folder
        dir = "tmp:/_cache"
        filesystem = createObject("roFileSystem")
        if not filesystem.exists(dir) then
            filesystem.createDirectory(dir)
        end if

        ' create the cache
        m.cache = {

            buffer:     createObject("roByteArray"),
            date:       createObject("roDateTime"),
            logger:     buLogger("cache"),
            dir:        dir,
            maxSize:    150,
            elements:   [],

            ' Adds the data from an operation to the cache.
            ' @param {String} rawKey a unique String for the operation (i.e. the URI)
            ' @param {String} data to be stored in the cache
            ' @param {Integer} TTL of the cached data in seconds
            ' @return {String} the created MD5 key for this cached object (not usable)
            add: function(rawKey as String, data as String, ttl as Integer) as Dynamic
                key = toMD5Hash(rawKey)
                obj = getCacheObject(key, ttl)

                m._flush() ' first flush the cache

                if m.elements.count() >= m.maxSize then
                    m.logger.debug("Exceeding the size of the cache. Stop inserting")
                    return Invalid
                end if

                m.logger.debug("Adding {0} to cache for {1} seconds", rawKey, ttl)

                m.elements.push(obj)
                m._write(key, data)
                return key
            end function

            ' Obtains data for the given operation from the cache
            ' @param {String} rawKey a unique String for the operation (i.e. the URI)
            ' @return {Dynamic} the data stored (String) or Invalid if nothing is here
            get: function(rawKey as String) as Dynamic
                key = toMD5Hash(rawKey)
                cached = m._getElement(key)

                if cached = Invalid then
                    m.logger.debug("No cache hit for {0}", rawKey)
                    return Invalid
                end if

                if not m._checkTTL(cached) then
                    m.logger.debug("TTL passed. Deleting {0} from cache", rawKey)
                    m._removeElement(key)
                    return Invalid
                end if

                m.logger.info("Cache Hit for: {0}", rawKey)
                return m._read(key)
            end function

            ' Retuns true if the key is present in the reference array
            _exists: function(key as String) as Boolean
                return m._getElement(key) <> Invalid
            end function

            ' Returns an element for the given key from the reference array
            _getElement: function(key as String) as Dynamic
                for each el in m.elements
                    if el.key = key then
                        return el
                    end if
                end for
                return Invalid
            end function

            ' Removes an element form the reference array detroying the reference
            ' to the stored data and the file.
            _removeElement: function(key as String) as Void
                indexToDelete = Invalid
                for i = 0 to m.elements.count() - 1 step +1
                    el = m.elements[i]
                    if el.key = key then
                        indexToDelete = i
                        exit for
                    end if
                end for

                if indexToDelete <> Invalid then
                    m.elements.delete(indexToDelete)
                    filesystem = createObject("roFileSystem")
                    filesystem.delete(m.dir + "/" + key)
                end if

            end function

            ' Writes the given string to the given filename in /tmp
            _write: function(filename as String, data as String) as Void
                ' print "write file " ; filename
                m.buffer.fromAsciiString(data)
                m.buffer.writeFile(m.dir + "/" + filename)
            end function

            ' Reads the data from the given filename in /tmp
            _read: function(filename as String) as String
                ' print "Read file " ; filename
                m.buffer.readFile(m.dir + "/" + filename)
                return m.buffer.toAsciiString()
            end function

            ' Checks if the TTL has been expired for a given cached object
            ' @return {Boolean} true if the reference is still valid.
            _checkTTL: function(cached as Object) as Boolean
                m.date.mark()
                now = m.date.asSeconds()
                return (now - cached.created) < cached.ttl
            end function

            ' Checks the reference array for expired references
            ' and removes them if the maxSize has been reached
            _flush: function() as Void
                copy = []

                for each el in m.elements
                    if m._checkTTL(el) then
                        copy.push(el)
                    end if
                end for

                m.elements = copy
            end function

        }
    end if
    return m.cache

end function

' An object to be used a reference to the stored data.
' @param {String} a UUID identifying this reference
' @param {Integer} the TTL of this reference
function getCacheObject(key as String, ttl as Integer) as Object
    return {
        key:        key,
        ttl:        ttl,
        created:    createObject("roDateTime").asSeconds()
    }
end function
