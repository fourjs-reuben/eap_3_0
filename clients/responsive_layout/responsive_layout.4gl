MAIN
DEFINE size STRING
DEFINE pos INTEGER
DEFINE width,height INTEGER

    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "responsive_layout"
    MENU ""
        ON ACTION windowresized ATTRIBUTES(DEFAULTVIEW=NO)
            CALL ui.Interface.frontCall("standard","feInfo",["windowSize"],[size])
            LET pos = size.getIndexOf("x",1)
            LET width = size.subString(1,pos-1)
            LET height = size.subString(pos+1, size.getLength())
            DISPLAY BY NAME width, height
            
        ON ACTION close
            EXIT MENU
    END MENU
END MAIN