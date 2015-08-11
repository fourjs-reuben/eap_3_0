MAIN
    CALL ui.Interface.loadStyles("emptyrowcol")
    OPEN WINDOW w WITH FORM "emptyrowcol"
    MENU ""
        ON ACTION accept
            EXIT MENU
    END MENU
END MAIN