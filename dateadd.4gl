MAIN
DEFINE x INTEGER
DEFINE i INTERVAL MONTH TO MONTH

    DEFINE d0, d datetime year to second

    LET i = INTERVAL(1) MONTH TO MONTH
   
    LET x=0
    LET d0 = MDY(01, 31, 2015)
    LET d = d0 + x UNITS MONTH; DISPLAY d
    LET d = d0+ i; DISPLAY d
    LET d = d0- i; DISPLAY d
    LET d = d0 + 13 UNITS MONTH; DISPLAY d
    LET d = d0 - 1 UNITS MONTH; DISPLAY d
    LET d = d0 - 2 UNITS MONTH; DISPLAY d
END MAIN