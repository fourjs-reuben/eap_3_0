

# Replace these with values applicable for your environment
CONSTANT IPADDRESS = "192.168.0.14"
CONSTANT PORT=6395
CONSTANT APP="stack_reubenbarclay"

MAIN
DEFINE url STRING
    -- DISPLAY FGL_GETENV("LANG")
    -- RUN "locale"
    
    MENU ""
        ON ACTION run ATTRIBUTES(TEXT="Run")
            TRY
                LET url = SFMT("http://%1:%2/ua/r/%3", IPADDRESS,PORT, APP)
                CALL ui.Interface.frontCall("mobile","runOnServer",["http://192.168.0.14:6395/ua/r/stack_reubenbarclay"],[])
            CATCH
                DISPLAY err_get(STATUS)
            END TRY
        ON ACTION close
            EXIT MENU
    END MENU
END MAIN