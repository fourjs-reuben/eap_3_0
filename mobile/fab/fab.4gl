MAIN
DEFINE arr DYNAMIC ARRAY OF RECORD
    field1 STRING
END RECORD
DEFINE i INTEGER

    FOR i = 1 TO 3
        LET arr[i].field1 = i
    END FOR

    OPEN WINDOW w WITH FORM "fab"
    MENU ""
        ON ACTION fab ATTRIBUTES(TEXT="Append Active")
            DISPLAY ARRAY arr TO scr.* ATTRIBUTES(UNBUFFERED)
                ON APPEND
                MESSAGE "Append"
                LET arr[arr_curr()].field1 = arr_curr()
            END DISPLAY
            CLEAR FORM

        ON ACTION update_fab ATTRIBUTES(TEXT="Update Active")
            DISPLAY ARRAY arr TO scr.* ATTRIBUTES(UNBUFFERED)
                ON ACTION update
                MESSAGE "Update"
            END DISPLAY
            CLEAR FORM

        ON ACTION close
            EXIT MENU

    END MENU
END MAIN