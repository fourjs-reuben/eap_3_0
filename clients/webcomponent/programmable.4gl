
MAIN
DEFINE html STRING
DEFINE l_result STRING
DEFINE wc STRING

    LET html = '<iframe  src="https://www.youtube.com/embed/dM9rKLB7_2o" width="400" height="300" frameborder="0"></iframe>'
    OPEN WINDOW programmable WITH FORM "programmable" ATTRIBUTES(TEXT="Embedded Video")
    
    INPUT BY NAME wc ATTRIBUTES(ACCEPT=FALSE, CANCEL=FALSE, UNBUFFERED)
        ON ACTION video1
            LET html = '<iframe  src="https://www.youtube.com/embed/dM9rKLB7_2o" width="400" height="300" frameborder="0"></iframe>'
            CALL ui.interface.frontcall("webcomponent","call",["formonly.wc","setById","root",html],l_result)
        ON ACTION video2
            LET html = '<iframe  src="https://www.youtube.com/embed/jybEkP-ft2Y" width="400" height="300" frameborder="0"></iframe>'
            CALL ui.interface.frontcall("webcomponent","call",["formonly.wc","setById","root",html],l_result)
        ON ACTION cancel    
            EXIT INPUT
        ON ACTION CLOSE
            EXIT INPUT
    END INPUT
    CLOSE WINDOW programmable
END MAIN