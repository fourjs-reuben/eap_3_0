MAIN
DEFINE msg STRING
DEFINE ch base.Channel

    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "base_channel_client"

    OPTIONS INPUT WRAP

    INPUT BY NAME msg ATTRIBUTES(UNBUFFERED, ACCEPT=FALSE)
        ON ACTION send
            LET ch = base.Channel.create()
            CALL ch.openClientSocket("127.0.0.1",4711,"w",15)
            CALL ch.writeLine(msg)
            CALL ch.close()
            INITIALIZE msg TO NULL
            NEXT FIELD msg
    END INPUT
END MAIN
            