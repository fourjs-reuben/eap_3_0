MAIN
    DEFINE io base.Channel
    DEFINE s, msg STRING

    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "base_channel_server"
    CALL ui.Interface.refresh()
    LET io = base.Channel.create()
    CALL io.openServerSocket("127.0.0.1", 4711, "u")
    WHILE TRUE
        LET s = io.readLine() 
        LET msg = SFMT("Message received at %1:\n%2", CURRENT HOUR TO SECOND, msg)
        LET msg = s,"\n",msg
        CALL io.writeLine(ASCII 26) -- EOF
        DISPLAY BY NAME msg
        CALL ui.Interface.refresh()
        

    END WHILE
END MAIN