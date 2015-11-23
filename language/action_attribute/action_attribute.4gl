MAIN
    MENU ""
        ON ACTION action1  -- No attributes defined
            MESSAGE "action1"
            
        COMMAND "Action 2" -- Kept for backward compatability, defaults text value
            MESSAGE "action2"
            
        ON ACTION action3 ATTRIBUTES(TEXT="Action 3", IMAGE="smiley") -- Useful for one-off actions
            MESSAGE "action3"

        ON ACTION cancel -- No override, value from .4ad
            MESSAGE "cancel"
            
        ON ACTION accept ATTRIBUTES(TEXT="My OK") -- Override values in .4ad
            MESSAGE "accept"
        ON ACTION close
            EXIT MENU
    END MENU
END MAIN