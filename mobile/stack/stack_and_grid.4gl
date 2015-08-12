MAIN
    OPTIONS INPUT WRAP
    MENU ""
        ON ACTION grid ATTRIBUTES(TEXT="Grid")
            CALL do_test("grid")
        ON ACTION stack ATTRIBUTES(TEXT="Stack")
            CALL do_test("stack")
        ON ACTION close
            EXIT MENU
    END MENU
END MAIN

FUNCTION do_test(formname)
DEFINE formname STRING
DEFINE title STRING
DEFINE filter BOOLEAN
DEFINE date_from, date_to DATE


    OPEN WINDOW w WITH FORM formname
    LET date_from = TODAY-365
    LET date_to = TODAY
    LET filter = TRUE
    INPUT BY NAME title, filter, date_from, date_to ATTRIBUTES(WITHOUT DEFAULTS=TRUE)
    CLOSE WINDOW w
END FUNCTION