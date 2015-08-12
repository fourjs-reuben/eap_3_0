IMPORT util

DEFINE cursor_arr DYNAMIC ARRAY OF RECORD
    columnlist STRING,
    tablename STRING,
    sh base.SqlHandle
END RECORD

MAIN
DEFINE sql base.SqlHandle
DEFINE ok BOOLEAN
DEFINE result1, result2 STRING
DEFINE i INTEGER

    CONNECT TO ":memory:"

    CREATE TABLE dummy
    (key INTEGER,
     value1 INTEGER,
     value2 CHAR(40))

     INSERT INTO dummy VALUES(1,100,"One")
     INSERT INTO dummy VALUES(2,200,"Two")

     CREATE TABLE dummy2
    (key1 CHAR(10),
     key2 INTEGER,
     value1 INTEGER,
     value2 CHAR(40))

     INSERT INTO dummy2 VALUES("AAA",1,1000,"One")
     INSERT INTO dummy2 VALUES("AAA",2,2000,"Two")

    -- 1 value
     CALL qselect("value1","dummy", json1("key",1)) RETURNING ok, result1
     DISPLAY ok, result1

     -- test correct column returned
     CALL qselect("value2","dummy", json1("key",1)) RETURNING ok, result1
     DISPLAY ok, result1

     -- test diff primary key value
     CALL qselect("value1","dummy", json1("key",2)) RETURNING ok, result1
     DISPLAY ok, result1

     --notfound
     CALL qselect("value1","dummy", json1("key",3)) RETURNING ok, result1
     DISPLAY ok, result1

     -- 2 values
     CALL qselect("value1,value2","dummy", json1("key",1)) RETURNING ok, result1, result2
     DISPLAY ok, result1, result2

     -- 2 key
     CALL qselect("value1","dummy2", json2("key1","AAA","key2",1)) RETURNING ok, result1
     DISPLAY ok, result1
     
      -- 2 key
     CALL qselect("value1","dummy2", json2("key1","AAA","key2",2)) RETURNING ok, result1
     DISPLAY ok, result1

      -- 2 key
     CALL qselect("value1,value2","dummy2", json2("key1","AAA","key2",1)) RETURNING ok, result1, result2
     DISPLAY ok, result1, result2

       -- 2 key
     CALL qselect("value1,value2","dummy2", json2("key1","AAA","key2",2)) RETURNING ok, result1, result2
     DISPLAY ok, result1, result2

    FOR i = 1 TO cursor_arr.getLEngth()
        DISPLAY cursor_arr[i].tablename
        DISPLAY cursor_arr[i].columnlist
    END FOR

     
END MAIN


-- To read qselect it is
-- Select COLUMNLIST from TABLENAME WHERE PRIMARYKEY LOOKUP
FUNCTION qselect(columnlist, tablename, where)
DEFINE columnlist STRING
DEFINE tablename STRING
DEFINE where util.JSONObject

DEFINE sql base.StringBuffer
DEFINE i INTEGER
DEFINE key_column_name STRING


    
DEFINE l_status INTEGER

DEFINE l_result1, l_result2 STRING
DEFINE idx INTEGER

    FOR idx =1 TO cursor_arr.getLength()
        IF cursor_arr[idx].columnlist = columnlist THEN
            IF cursor_arr[idx].tablename = tablename THEN
                -- Found match, re-use cursor
                EXIT FOR
            END IF
        END IF
    END FOR

    IF idx > cursor_arr.getLength() THEN
        LET cursor_arr[idx].columnlist = columnlist
        LET cursor_arr[idx].tablename = tablename
        -- Create new entry   
        LET sql = base.StringBuffer.create()

        CALL sql.append("SELECT ")
        CALL sql.append(columnlist.trim())
        CALL sql.append(" FROM ")
        CALL sql.append(tablename)

     
        FOR i = 1 TO where.getLength()
            IF i = 1 THEN
                CALL sql.append(" WHERE (")
            ELSE
                CALL sql.append(" AND ")
            END IF
            LET key_column_name = where.name(i)
            CALL sql.append(key_column_name)
            CALL sql.append(" = ")
            CALL sql.append(" ? ")
        END FOR
        CALL sql.append(")")

        LET cursor_arr[idx].sh = base.SQLHandle.create()
    
   
        CALL cursor_arr[idx].sh.prepare(sql.toString())
    END IF

    FOR i = 1 TO where.getLength()
        CALL cursor_arr[idx].sh.setParameter(i,where.get(where.name(i)))
    END FOR
    
    CALL cursor_arr[idx].sh.open()

    CALL cursor_arr[idx].sh.fetch()
    LET l_status = SQLCA.sqlcode

    CASE cursor_arr[idx].sh.getResultCount()
        WHEN 0
            IF l_status = NOTFOUND THEN
                RETURN FALSE
            ELSE
                RETURN TRUE
            END IF
        WHEN 1
            IF l_status = NOTFOUND THEN
                RETURN FALSE, NULL
            ELSE
                LET l_result1 = cursor_arr[idx].sh.getResultValue(1)
                RETURN TRUE, l_result1
                #RETURN TRUE, sh.getResultValue(1)
            END IF
        WHEN 2
            IF l_status = NOTFOUND THEN
                RETURN FALSE, NULL, NULL
            ELSE
                LET l_result1 = cursor_arr[idx].sh.getResultValue(1)
                LET l_result2 = cursor_arr[idx].sh.getResultValue(2)
                RETURN TRUE, l_result1, l_result2
                #RETURN TRUE, sh.getResultValue(1), sh.getResultValue(2)
            END IF
        # ... carry on upto hard limit
    END CASE
END FUNCTION 


FUNCTION json1(name1, value1)
DEFINE name1, value1 STRING
DEFINE j util.JSONObject

    LET j = util.JSONObject.create()
    CALL j.put(name1,value1)
    RETURN j
END FUNCTION

FUNCTION json2(name1, value1, name2, value2)
DEFINE name1, value1, name2, value2 STRING
DEFINE j util.JSONObject

    LET j = json1(name1,value1)
    CALL j.put(name2,value2)
    RETURN j
END FUNCTION

FUNCTION json3(name1, value1, name2, value2, name3, value3)
DEFINE name1, value1, name2, value2,name3, value3 STRING
DEFINE j util.JSONObject

    LET j = json2(name1, value1, name2, value2)
    CALL j.put(name3,value3)
    RETURN j
END FUNCTION

FUNCTION json4(name1, value1, name2, value2, name3, value3, name4, value4)
DEFINE name1, value1, name2, value2,name3, value3, name4, value4 STRING
DEFINE j util.JSONObject

    LET j = json3(name1, value1, name2, value2,name3, value3)
    CALL j.put(name4,value4)
    RETURN j
END FUNCTION

FUNCTION json5(name1, value1, name2, value2, name3, value3, name4, value4, name5, value5)
DEFINE name1, value1, name2, value2,name3, value3, name4, value4, name5, value5 STRING
DEFINE j util.JSONObject

    LET j = json4(name1, value1, name2, value2, name3, value3, name4, value4)
    CALL j.put(name5,value5)
    RETURN j
END FUNCTION

FUNCTION json6(name1, value1, name2, value2, name3, value3, name4, value4, name5, value5, name6, value6)
DEFINE name1, value1, name2, value2,name3, value3, name4, value4, name5, value5, name6, value6 STRING
DEFINE j util.JSONObject

    LET j = json5(name1, value1, name2, value2,name3, value3, name4, value4, name5, value5)
    CALL j.put(name6,value6)
    RETURN j
END FUNCTION


FUNCTION json7(name1, value1, name2, value2, name3, value3, name4, value4, name5, value5, name6, value6, name7, value7)
DEFINE name1, value1, name2, value2,name3, value3, name4, value4, name5, value5, name6, value6, name7, value7 STRING
DEFINE j util.JSONObject

    LET j = json6(name1, value1, name2, value2,name3, value3, name4, value4, name5, value5, name6, value6)
    CALL j.put(name7,value7)
    RETURN j
END FUNCTION

FUNCTION json8(name1, value1, name2, value2, name3, value3, name4, value4, name5, value5, name6, value6, name7, value7, name8, value8)
DEFINE name1, value1, name2, value2,name3, value3, name4, value4, name5, value5, name6, value6, name7, value7, name8, value8 STRING
DEFINE j util.JSONObject

    LET j = json7(name1, value1, name2, value2,name3, value3, name4, value4, name5, value5, name6, value6, name7, value7)
    CALL j.put(name8,value8)
    RETURN j
END FUNCTION

FUNCTION json9(name1, value1, name2, value2, name3, value3, name4, value4, name5, value5, name6, value6, name7, value7, name8, value8, name9, value9)
DEFINE name1, value1, name2, value2,name3, value3, name4, value4, name5, value5, name6, value6, name7, value7, name8, value8, name9, value9 STRING
DEFINE j util.JSONObject

    LET j = json8(name1, value1, name2, value2,name3, value3, name4, value4, name5, value5, name6, value6, name7, value7, name8, value8)
    CALL j.put(name9,value9)
    RETURN j
END FUNCTION