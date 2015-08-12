IMPORT util
MAIN
DEFINE time1, time2, time3, time4, utc3, utc4 DATETIME YEAR TO SECOND
DEFINE seconds1, seconds2 INTEGER

    OPTIONS FIELD ORDER FORM
    OPTIONS INPUT WRAP
    OPEN WINDOW w WITH FORM "datetime_utility"


    LET seconds1 = util.Datetime.toSecondsSinceEpoch(CURRENT)
    LET time2 = CURRENT 
    LET utc3 = util.Datetime.toUtc(CURRENT)
    LET time4 = CURRENT 

    INPUT BY NAME time1, time2, time3, time4, utc3, utc4,seconds1, seconds2 ATTRIBUTES(UNBUFFERED, ACCEPT=FALSE, WITHOUT DEFAULTS=TRUE)
        ON ACTION seconds2time
            LET time1 = util.Datetime.fromSecondsSinceEpoch(seconds1)
        ON ACTION time2seconds
            LET seconds2 = util.Datetime.toSecondsSinceEpoch(time2)
        ON ACTION utc2time
            LET time3 = util.Datetime.toLocalTime(utc3)
        ON ACTION time2utc
            LET utc4 = util.Datetime.toUTC(time4)
    END INPUT
END MAIN