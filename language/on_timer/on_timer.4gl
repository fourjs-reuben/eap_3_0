IMPORT util

DEFINE arr DYNAMIC ARRAY OF RECORD
    job_id INTEGER,
    created_time DATETIME HOUR TO SECOND
END RECORD
DEFINE m_id INTEGER

MAIN
DEFINE l_operator INTEGER

    CLOSE WINDOW SCREEN
    OPEN WINDOW on_timer WITH FORM "on_timer"
    DISPLAY ARRAY arr TO scr.* ATTRIBUTES(UNBUFFERED)
    
        ON TIMER 1 -- Poll every second (in practise set to higher value)
            MESSAGE "Poll called at ",CURRENT HOUR TO SECOND
            CALL poll_new_jobs()

        ON ACTION assign ATTRIBUTES(TEXT="Assign Job")
            PROMPT "Enter operator to assign to" FOR l_operator
            IF int_flag THEN
                LET int_Flag = 0
            ELSE
                CALL arr.deleteElement(arr_curr())
            END IF
            
    END DISPLAY
END MAIN

FUNCTION poll_new_jobs()
DEFINE l_row INTEGER

    -- create a new job on average every 3 calls
    IF util.math.rand(3) = 0 THEN 
        LET m_id = m_id + 1
        LET l_row = arr.getLength() + 1
        LET arr[l_row].job_id = m_id
        LET arr[l_row].created_time = CURRENT HOUR TO SECOND
    END IF
END FUNCTION