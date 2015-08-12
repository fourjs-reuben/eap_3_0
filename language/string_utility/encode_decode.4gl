
IMPORT util
MAIN
DEFINE s1, s2 STRING

    OPTIONS INPUT WRAP
    OPEN WINDOW w WITH FORM "encode_decode"
    INPUT BY NAME s1,s2 ATTRIBUTES(UNBUFFERED,ACCEPT=FALSE)
        ON ACTION urlencode
            LET s2 =  util.Strings.urlEncode(s1) 
        ON ACTION urldecode
            LET s2 = util.Strings.urlDecode(s1) 
        ON ACTION base64encode
            LET s2 = util.Strings.base64EncodeFromString(s1) 
        ON ACTION base64decode
            LET s2 = util.Strings.base64DecodeToString(s1) 
        ON ACTION usevalue
            LET s1 = s2
            INITIALIZE s2 TO NULL
    END INPUT
END MAIN