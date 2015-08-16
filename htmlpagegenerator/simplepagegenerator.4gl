IMPORT com
IMPORT xml

MAIN
DEFINE req com.HttpServiceRequest

DEFINE scheme, ipaddress, path, args STRING
DEFINE port INTEGER

DEFINE ok BOOLEAN
DEFINE test_result xml.DomDocument
    
    
    -- Initialize server
    CALL com.WebServiceEngine.Start()
  
    WHILE TRUE      
        LET req = com.WebServiceEngine.GetHttpServiceRequest(-1)
        IF req IS NULL THEN
            EXIT PROGRAM
        END IF

        -- Process request
        CALL parse_url(req.getUrl()) RETURNING
            scheme, ipaddress, port, path, args
        --DISPLAY scheme, ipaddress, port, path, args 

        IF path IS NULL THEN -- really bad url
            CALL req.sendResponse(500, NULL)
        ELSE
            CASE path
                WHEN "test"
                    -- Generate a simple HTML page, passing the arguments.
                    CALL generate_page_test(args) RETURNING ok, test_result
                    IF ok THEN
                        -- Return success and the page
                        CALL req.setResponseHeader("Content-Type","text/html")
                        CALL req.sendTextResponse(200,NULL,test_result.saveToString())
                    ELSE
                        -- Unable to generate page
                        CALL req.sendResponse(400, NULL)
                    END IF
                    
                OTHERWISE -- path value doesn't make sense
                    CALL req.sendResponse(400, NULL)
            END CASE
        END IF
    END WHILE
END MAIN



FUNCTION parse_url(url)
DEFINE url STRING
DEFINE pos1, pos2 INTEGER

DEFINE scheme, ipaddress, path, args STRING
DEFINE port INTEGER

    -- Parse url based on scheme://ipaddress:port/path?arguments
    
    LET pos2 = url.getIndexOf("://",1)
    IF pos2 > 0 THEN
        LET scheme = url.SubString(1,pos2)
    END IF

    IF pos2 > 0 THEN
        LET pos1 = pos2+3
    ELSE
        LET pos1 = 1
    END IF
    LET pos2 = url.getIndexOf("/",pos1)
    
    IF pos2 > 1 THEN
        LET ipaddress = url.subString(pos1,pos2-1)
        LET pos1 = ipaddress.getIndexOf(":",1)
        IF pos1>1 THEN
            LET port = ipaddress.subString(pos1+1,ipaddress.getLength())
            LET ipaddress = ipaddress.subString(1,pos1-1)
        ELSE
            # No port, use default according to scheme
            LET port = 0
            IF scheme.equalsIgnoreCase("http") THEN
                LET port = 80
            END IF
            IF scheme.equalsIgnoreCase("https") THEN
                LET port = 443
            END IF
        END IF
    END IF

    # Extract path and query
    LET pos1 = pos2+1
    LET pos2 = url.getIndexOf("?",pos1)
    IF pos2 > 1 THEN
        LET path = url.subString(pos1,pos2-1)
        LET args = url.subString(pos2+1, url.getLength())
    ELSE
        LET path = url.subString(pos1, url.getLength())
        LET args = NULL
    END IF
    RETURN scheme, ipaddress, port, path, args
END FUNCTION



FUNCTION generate_page_test(args)
DEFINE args STRING
DEFINE doc xml.DomDocument
DEFINE root, head, body, text_node xml.DomNode

    LET doc = xml.DomDocument.CreateDocument("html")
    CALL doc.setFeature("whitespace-in-element-content",FALSE)
    LET root = doc.getDocumentElement()
    LET head = root.appendChildElement("head")
    LET body = root.appendChildElement("body")

    -- create a simple text node
    LET text_node = doc.createTextNode(SFMT("This is test page, arguments passed were ... %1", args))
    CALL body.appendChild(text_node)

    RETURN TRUE, doc
END FUNCTION