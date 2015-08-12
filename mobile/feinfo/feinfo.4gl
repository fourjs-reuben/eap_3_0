MAIN
DEFINE fieldname, value STRING

    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "feinfo"
    INPUT BY NAME fieldname ATTRIBUTES(UNBUFFERED, ACCEPT=FALSE)
        ON CHANGE fieldname
        
            DISPLAY feinfo(fieldname) TO value
    END INPUT
END MAIN

FUNCTION feinfo(fieldname)
DEFINE fieldname, value STRING

    TRY
        CALL ui.Interface.frontCall("standard","feinfo",[fieldname], [value])
    CATCH
    END TRY
    RETURN value
END FUNCTION

FUNCTION combo_populate_feinfo(cb)
DEFINE cb ui.ComboBox

    CALL cb.clear()
    CALL cb.addItem("dataDirectory","dataDirectory")
    CALL cb.addItem("deviceModel","deviceModel")
    CALL cb.addItem("deviceId","deviceId")
    CALL cb.addItem("feName","feName")
    CALL cb.addItem("fePath","fePath")
    CALL cb.addItem("freeStorageSpace","freeStorageSpace")
    CALL cb.addItem("iccid","iccid")
    CALL cb.addItem("imei","imei")
    CALL cb.addItem("ip","ip")
    CALL cb.addItem("osType","osType")
    CALL cb.addItem("osVersion","osVersion")
    CALL cb.addItem("ppi","ppi")
    CALL cb.addItem("screenResolution","screenResolution")
    CALL cb.addItem("target","target")
    CALL cb.addItem("windowSize","windowSize")
END FUNCTION