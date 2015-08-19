DEFINE m_cursor_prepared BOOLEAN
CONSTANT COMPLETER_LIST_SIZE=50       -- maximum size of completer list
CONSTANT MINIMUM_COMPLETER_LENGTH=2   -- minimum characters to be entered

MAIN
DEFINE country STRING
DEFINE autoset BOOLEAN

DEFINE i INTEGER
DEFINE filter STRING
DEFINE completer_list DYNAMIC ARRAY OF STRING
DEFINE w ui.Window
DEFINE f ui.Form

DEFINE country_name CHAR(50)

    OPTIONS INPUT WRAP

    CALL ui.Interface.LoadStyles("auto_completion")
    
    CONNECT TO ":memory:"
    LET m_cursor_prepared = FALSE
    CALL init_database()
    
    CLOSE WINDOW SCREEN
    OPEN WINDOW w WITH FORM "auto_completion"
    LET w = ui.Window.getCurrent()
    LET f= w.getForm()

    INPUT BY NAME country, autoset ATTRIBUTES(UNBUFFERED, WITHOUT DEFAULTS=TRUE)
        ON CHANGE country
            IF NOT m_cursor_prepared THEN
                DECLARE country_curs CURSOR FROM SFMT("SELECT name FROM country WHERE UPPER(name) LIKE ? ORDER BY name LIMIT %1",COMPLETER_LIST_SIZE)
                LET m_cursor_prepared = TRUE
            END IF
          
            -- What user is currently typing is in the buffer, add % for LIKE 
            CALL completer_list.clear()
            LET filter = FGL_DIALOG_GETBUFFER()
            IF filter.getLength() >= MINIMUM_COMPLETER_LENGTH THEN
                LET filter = filter.toUpperCase(),"%"
                OPEN country_curs USING filter
                FOR i = 1 TO COMPLETER_LIST_SIZE
                    FETCH country_curs INTO country_name
                    IF status = NOTFOUND THEN
                        EXIT FOR
                    END IF
                    LET completer_list[i] = country_name CLIPPED
                END FOR
                
                IF autoset AND completer_list.getLength() = 1 THEN
                    -- If autoset enabled and there is one value, set the value and move to next field
                    LET country = completer_list[1]
                    CALL DIALOG.setCompleterItems(NULL)
                    CALL f.setfieldstyle("country","green")
                    NEXT FIELD NEXT
                ELSE
                    -- Display the list
                    CALL DIALOG.setCompleterItems(completer_list)
                END IF
                
                -- Change background colour based on number of matching entries
                CASE completer_list.getLength()
                    WHEN 1 CALL f.setfieldstyle("country","green")
                    WHEN 0 CALL f.setfieldstyle("country","red")
                    OTHERWISE CALL f.setfieldstyle("country","")
                END CASE
            ELSE
                CALL DIALOG.setCompleterItems(NULL)
                CALL f.setfieldstyle("country","")
            END IF
    END INPUT
END MAIN



FUNCTION init_database()

    CREATE TABLE country (name CHAR(50))

    INSERT INTO country VALUES("Afghanistan")
    INSERT INTO country VALUES("Aland Islands")
    INSERT INTO country VALUES("Albania")
    INSERT INTO country VALUES("Algeria")
    INSERT INTO country VALUES("American Samoa")
    INSERT INTO country VALUES("Andorra")
    INSERT INTO country VALUES("Angola")
    INSERT INTO country VALUES("Anguilla")
    INSERT INTO country VALUES("Antarctica")
    INSERT INTO country VALUES("Antigua and Barbuda")
    INSERT INTO country VALUES("Argentina")
    INSERT INTO country VALUES("Armenia")
    INSERT INTO country VALUES("Aruba")
    INSERT INTO country VALUES("Australia")
    INSERT INTO country VALUES("Austria")
    INSERT INTO country VALUES("Azerbaijan")
    INSERT INTO country VALUES("Bahamas")
    INSERT INTO country VALUES("Bahrain")
    INSERT INTO country VALUES("Bangladesh")
    INSERT INTO country VALUES("Barbados")
    INSERT INTO country VALUES("Belarus")
    INSERT INTO country VALUES("Belgium")
    INSERT INTO country VALUES("Belize")
    INSERT INTO country VALUES("Benin")
    INSERT INTO country VALUES("Bermuda")
    INSERT INTO country VALUES("Bhutan")
    INSERT INTO country VALUES("Bolivia")
    INSERT INTO country VALUES("Bosnia and Herzegovina")
    INSERT INTO country VALUES("Botswana")
    INSERT INTO country VALUES("Bouvet Island")
    INSERT INTO country VALUES("Brazil")
    INSERT INTO country VALUES("British Indian Ocean Territory")
    INSERT INTO country VALUES("Brunei Darussalam")
    INSERT INTO country VALUES("Bulgaria")
    INSERT INTO country VALUES("Burkina Faso")
    INSERT INTO country VALUES("Burundi")
    INSERT INTO country VALUES("Cambodia")
    INSERT INTO country VALUES("Cameroon")
    INSERT INTO country VALUES("Canada")
    INSERT INTO country VALUES("Cape Verde")
    INSERT INTO country VALUES("Cayman Islands")
    INSERT INTO country VALUES("Central African Republic")
    INSERT INTO country VALUES("Chad")
    INSERT INTO country VALUES("Chile")
    INSERT INTO country VALUES("China")
    INSERT INTO country VALUES("Christmas Island")
    INSERT INTO country VALUES("Cocos (Keeling) Islands")
    INSERT INTO country VALUES("Colombia")
    INSERT INTO country VALUES("Comoros")
    INSERT INTO country VALUES("Congo")
    INSERT INTO country VALUES("Congo, the Democratic Republic of the")
    INSERT INTO country VALUES("Cook Islands")
    INSERT INTO country VALUES("Costa Rica")
    INSERT INTO country VALUES("Cote D'Ivoire")
    INSERT INTO country VALUES("Croatia")
    INSERT INTO country VALUES("Cuba")
    INSERT INTO country VALUES("Cyprus")
    INSERT INTO country VALUES("Czech Republic")
    INSERT INTO country VALUES("Denmark")
    INSERT INTO country VALUES("Djibouti")
    INSERT INTO country VALUES("Dominica")
    INSERT INTO country VALUES("Dominican Republic")
    INSERT INTO country VALUES("Ecuador")
    INSERT INTO country VALUES("Egypt")
    INSERT INTO country VALUES("El Salvador")
    INSERT INTO country VALUES("Equatorial Guinea")
    INSERT INTO country VALUES("Eritrea")
    INSERT INTO country VALUES("Estonia")
    INSERT INTO country VALUES("Ethiopia")
    INSERT INTO country VALUES("Falkland Islands")
    INSERT INTO country VALUES("Faroe Islands")
    INSERT INTO country VALUES("Fiji")
    INSERT INTO country VALUES("Finland")
    INSERT INTO country VALUES("France")
    INSERT INTO country VALUES("French Guiana")
    INSERT INTO country VALUES("French Polynesia")
    INSERT INTO country VALUES("French Southern Territories")
    INSERT INTO country VALUES("Gabon")
    INSERT INTO country VALUES("Gambia")
    INSERT INTO country VALUES("Georgia")
    INSERT INTO country VALUES("Germany")
    INSERT INTO country VALUES("Ghana")
    INSERT INTO country VALUES("Gibraltar")
    INSERT INTO country VALUES("Greece")
    INSERT INTO country VALUES("Greenland")
    INSERT INTO country VALUES("Grenada")
    INSERT INTO country VALUES("Guadeloupe")
    INSERT INTO country VALUES("Guam")
    INSERT INTO country VALUES("Guatemala")
    INSERT INTO country VALUES("Guernsey")
    INSERT INTO country VALUES("Guinea")
    INSERT INTO country VALUES("Guinea-Bissau")
    INSERT INTO country VALUES("Guyana")
    INSERT INTO country VALUES("Haiti")
    INSERT INTO country VALUES("Heard Island and Mcdonald Islands")
    INSERT INTO country VALUES("Holy See (Vatican City State)")
    INSERT INTO country VALUES("Honduras")
    INSERT INTO country VALUES("Hong Kong")
    INSERT INTO country VALUES("Hungary")
    INSERT INTO country VALUES("Iceland")
    INSERT INTO country VALUES("India")
    INSERT INTO country VALUES("Indonesia")
    INSERT INTO country VALUES("Iran, Islamic Republic of")
    INSERT INTO country VALUES("Iraq")
    INSERT INTO country VALUES("Ireland")
    INSERT INTO country VALUES("Isle of Man")
    INSERT INTO country VALUES("Israel")
    INSERT INTO country VALUES("Italy")
    INSERT INTO country VALUES("Jamaica")
    INSERT INTO country VALUES("Japan")
    INSERT INTO country VALUES("Jersey")
    INSERT INTO country VALUES("Jordan")
    INSERT INTO country VALUES("Kazakhstan")
    INSERT INTO country VALUES("Kenya")
    INSERT INTO country VALUES("Kiribati")
    INSERT INTO country VALUES("Korea, Democratic People's Republic of")
    INSERT INTO country VALUES("Korea, Republic of")
    INSERT INTO country VALUES("Kuwait")
    INSERT INTO country VALUES("Kyrgyzstan")
    INSERT INTO country VALUES("Lao people's Democratic Republic")
    INSERT INTO country VALUES("Latvia")
    INSERT INTO country VALUES("Lebanon")
    INSERT INTO country VALUES("Lesotho")
    INSERT INTO country VALUES("Liberia")
    INSERT INTO country VALUES("Libyan Arab Jamahiriya")
    INSERT INTO country VALUES("Liechtenstein")
    INSERT INTO country VALUES("Lithuania")
    INSERT INTO country VALUES("Luxembourg")
    INSERT INTO country VALUES("Macao")
    INSERT INTO country VALUES("Macedonia, the Former Yugoslav Republic of")
    INSERT INTO country VALUES("Madagascar")
    INSERT INTO country VALUES("Malawi")
    INSERT INTO country VALUES("Malaysia")
    INSERT INTO country VALUES("Maldives")
    INSERT INTO country VALUES("Mali")
    INSERT INTO country VALUES("Malta")
    INSERT INTO country VALUES("Marshall Islands")
    INSERT INTO country VALUES("Martinique")
    INSERT INTO country VALUES("Mauritania")
    INSERT INTO country VALUES("Mauritius")
    INSERT INTO country VALUES("Mayotte")
    INSERT INTO country VALUES("Mexico")
    INSERT INTO country VALUES("Micronesia, Federated States of")
    INSERT INTO country VALUES("Moldova")
    INSERT INTO country VALUES("Monaco")
    INSERT INTO country VALUES("Mongolia")
    INSERT INTO country VALUES("Montenegro")
    INSERT INTO country VALUES("Montserrat")
    INSERT INTO country VALUES("Morocco")
    INSERT INTO country VALUES("Mozambique")
    INSERT INTO country VALUES("Myanmar")
    INSERT INTO country VALUES("Namibia")
    INSERT INTO country VALUES("Nauru")
    INSERT INTO country VALUES("Nepal")
    INSERT INTO country VALUES("Netherlands")
    INSERT INTO country VALUES("Netherlands Antilles")
    INSERT INTO country VALUES("New Caledonia")
    INSERT INTO country VALUES("New Zealand")
    INSERT INTO country VALUES("Nicaragua")
    INSERT INTO country VALUES("Niger")
    INSERT INTO country VALUES("Nigeria")
    INSERT INTO country VALUES("Niue")
    INSERT INTO country VALUES("Norfolk Island")
    INSERT INTO country VALUES("Northern Mariana Islands")
    INSERT INTO country VALUES("Norway")
    INSERT INTO country VALUES("Oman")
    INSERT INTO country VALUES("Pakistan")
    INSERT INTO country VALUES("Palau")
    INSERT INTO country VALUES("Palestinian Territory, Occupied")
    INSERT INTO country VALUES("Panama")
    INSERT INTO country VALUES("Papua New Guinea")
    INSERT INTO country VALUES("Paraguay")
    INSERT INTO country VALUES("Peru")
    INSERT INTO country VALUES("Philippines")
    INSERT INTO country VALUES("Pitcairn")
    INSERT INTO country VALUES("Poland")
    INSERT INTO country VALUES("Portugal")
    INSERT INTO country VALUES("Puerto Rico")
    INSERT INTO country VALUES("Qatar")
    INSERT INTO country VALUES("Reunion")
    INSERT INTO country VALUES("Romania")
    INSERT INTO country VALUES("Russian Federation")
    INSERT INTO country VALUES("Rwanda")
    INSERT INTO country VALUES("Saint Barthelemy")
    INSERT INTO country VALUES("Saint Helena")
    INSERT INTO country VALUES("Saint Kitts and Nevis")
    INSERT INTO country VALUES("Saint Lucia")
    INSERT INTO country VALUES("Saint Martin")
    INSERT INTO country VALUES("Saint Pierre and Miquelon")
    INSERT INTO country VALUES("Saint Vincent and the Grenadines")
    INSERT INTO country VALUES("Samoa")
    INSERT INTO country VALUES("San Marino")
    INSERT INTO country VALUES("Sao Tome and Principe")
    INSERT INTO country VALUES("Saudi Arabia")
    INSERT INTO country VALUES("Senegal")
    INSERT INTO country VALUES("Serbia")
    INSERT INTO country VALUES("Seychelles")
    INSERT INTO country VALUES("Sierra Leone")
    INSERT INTO country VALUES("Singapore")
    INSERT INTO country VALUES("Slovakia")
    INSERT INTO country VALUES("Slovenia")
    INSERT INTO country VALUES("Solomon Islands")
    INSERT INTO country VALUES("Somalia")
    INSERT INTO country VALUES("South Africa")
    INSERT INTO country VALUES("South Georgia and the South Sandwich Islands")
    INSERT INTO country VALUES("Spain")
    INSERT INTO country VALUES("Sri Lanka")
    INSERT INTO country VALUES("Sudan")
    INSERT INTO country VALUES("Suriname")
    INSERT INTO country VALUES("Svalbard and Jan Mayen")
    INSERT INTO country VALUES("Swaziland")
    INSERT INTO country VALUES("Sweden")
    INSERT INTO country VALUES("Switzerland")
    INSERT INTO country VALUES("Syrian Arab Republic")
    INSERT INTO country VALUES("Taiwan, Province of China")
    INSERT INTO country VALUES("Tajikistan")
    INSERT INTO country VALUES("Tanzania, United Republic of")
    INSERT INTO country VALUES("Thailand")
    INSERT INTO country VALUES("Timor-leste")
    INSERT INTO country VALUES("Togo")
    INSERT INTO country VALUES("Tokelau")
    INSERT INTO country VALUES("Tonga")
    INSERT INTO country VALUES("Trinidad and Tobago")
    INSERT INTO country VALUES("Tunisia")
    INSERT INTO country VALUES("Turkey")
    INSERT INTO country VALUES("Turkmenistan")
    INSERT INTO country VALUES("Turks and Caicos Islands")
    INSERT INTO country VALUES("Tuvalu")
    INSERT INTO country VALUES("Uganda")
    INSERT INTO country VALUES("Ukraine")
    INSERT INTO country VALUES("United Arab Emirates")
    INSERT INTO country VALUES("United Kingdom")
    INSERT INTO country VALUES("United States")
    INSERT INTO country VALUES("United States Minor Outlying Islands")
    INSERT INTO country VALUES("Uruguay")
    INSERT INTO country VALUES("Uzbekistan")
    INSERT INTO country VALUES("Vanuatu")
    INSERT INTO country VALUES("Vatican City State")
    INSERT INTO country VALUES("Venezuela")
    INSERT INTO country VALUES("Viet Nam")
    INSERT INTO country VALUES("Virgin Islands, British")
    INSERT INTO country VALUES("Virgin Islands, U.S.")
    INSERT INTO country VALUES("Wallis and Futuna")
    INSERT INTO country VALUES("Western Sahara")
    INSERT INTO country VALUES("Yemen")
    INSERT INTO country VALUES("Zambia")
    INSERT INTO country VALUES("Zimbabwe")
END FUNCTION