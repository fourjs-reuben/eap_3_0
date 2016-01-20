IMPORT os
MAIN
DEFINE arr DYNAMIC ARRAY OF RECORD
    imagename STRING,
    code STRING,
    img STRING
END RECORD
DEFINE ch base.Channel
DEFINE filename, line STRING
DEFINE equal_pos, colon_pos STRING

    DISPLAY FGL_GETENV("FGLIMAGEPATH")

    LET ch = base.Channel.create()
    LET filename = SFMT("%1%2lib%2image2font.txt",FGL_GETENV("FGLDIR"), os.Path.separator())
    CALL ch.openFile(filename,"r")
    WHILE TRUE
        LET line = ch.readLine()
        IF ch.isEof() THEN
            EXIT WHILE
        END IF
        IF line MATCHES "#*" THEN
            -- ignore comments
            CONTINUE WHILE
        END IF
        LET equal_pos = line.getIndexOf("=",1)
        LET colon_pos = line.getIndexOf(":",1)
        LET arr[arr.getLength()+1].imagename = line.subString(1,equal_pos-1)
        LET arr[arr.getLength()].img = arr[arr.getLength()].imagename

        LET arr[arr.getLength()].code = line.subString(colon_pos+1, line.getLength())
    END WHILE
    CALL ch.close()

    LET ch = base.Channel.create()
    LET filename = "my_image2font.txt"
    CALL ch.openFile(filename,"r")
    WHILE TRUE
        LET line = ch.readLine()
        IF ch.isEof() THEN
            EXIT WHILE
        END IF
        IF line MATCHES "#*" THEN
            -- ignore comments
            CONTINUE WHILE
        END IF
        LET equal_pos = line.getIndexOf("=",1)
        LET colon_pos = line.getIndexOf(":",1)
        LET arr[arr.getLength()+1].imagename = line.subString(1,equal_pos-1)
        LET arr[arr.getLength()].img = arr[arr.getLength()].imagename

        LET arr[arr.getLength()].code = line.subString(colon_pos+1, line.getLength())
    END WHILE
    CALL ch.close()
    

    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "fontawesome"
    DISPLAY ARRAY arr TO scr.*
        BEFORE ROW
            DISPLAY arr[arr_curr()].img TO img2
    END DISPLAY
END MAIN

