DEFINE list DYNAMIC ARRAY OF STRING

MAIN
DEFINE country STRING
DEFINE autoset BOOLEAN


DEFINE i INTEGER
DEFINE filter STRING
DEFINE completer_list DYNAMIC ARRAY OF STRING
DEFINE w ui.Window
DEFINE f ui.Form

DEFINE upper_filter, upper_list_element STRING


    OPTIONS INPUT WRAP
    CLOSE WINDOW SCREEN
    CALL ui.Interface.LoadStyles("auto_completion")
    CALL load_data()
    

    OPEN WINDOW w WITH FORM "auto_completion"
    LET w = ui.Window.getCurrent()
    LET f= w.getForm()

    INPUT BY NAME country, autoset ATTRIBUTES(UNBUFFERED, WITHOUT DEFAULTS=TRUE)
        ON CHANGE country
            CALL completer_list.clear()
          
            -- What user is currently typing is in buffer, add * for later matches
            LET filter = FGL_DIALOG_GETBUFFER()
            IF filter.getLength() > 0 THEN
                LET filter = filter,"*"

                -- Go through list and only include elements that match
                LET upper_filter = filter.toUpperCase()
                FOR i = 1 TO list.getLength()
                    LET upper_list_element = list[i].toUpperCase()
                    IF upper_list_element MATCHES upper_filter THEN
                        LET completer_list[completer_list.getLength()+1] = list[i]
                    END IF
                    -- SLEEP 1 --Uncomment this to note effect of slow code
                    IF completer_list.getLength()>=50 THEN
                        EXIT FOR
                    END IF
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
                CALL f.setfieldstyle("country","")
            END IF
    END INPUT
END MAIN

FUNCTION load_data()
   -- I wonder if there is a public web service that will return these values
   CALL list.clear()
   LET list[1] = "Afghanistan"
   LET list[2] = "Aland Islands"
   LET list[3] = "Albania"
   LET list[4] = "Algeria"
   LET list[5] = "American Ssamoa"
   LET list[6] = "Andorra"
   LET list[7] = "Aangola"
   LET list[8] = "Anguilla"
   LET list[9] = "Antarctica"
   LET list[10] = "Antigua and Barbuda"
   LET list[11] = "Argentina"
   LET list[12] = "Armenia"
   LET list[13] = "Aruba"
   LET list[14] = "Australia"
   LET list[15] = "Austria"
   LET list[16] = "Azerbaijan"
   LET list[17] = "Bahamas"
   LET list[18] = "Bahrain"
   LET list[19] = "Bangladesh"
   LET list[20] = "Barbados"
   LET list[21] = "Belarus"
   LET list[22] = "Belgium"
   LET list[23] = "Belize"
   LET list[24] = "Benin"
   LET list[25] = "Bermuda"
   LET list[26] = "Bhutan"
   LET list[27] = "Bolivia"
   LET list[28] = "Bbosnia and Herzegovina"
   LET list[29] = "Botswana"
   LET list[30] = "Bouvet Island"
   LET list[31] = "Brazil"
   LET list[32] = "British Indian Ocean Territory"
   LET list[33] = "Brunei Darussalam"
   LET list[34] = "Bulgaria"
   LET list[35] = "Burkina Faso"
   LET list[36] = "Burundi"
   LET list[37] = "Ccambodia"
   LET list[38] = "Cameroon"
   LET list[39] = "Canada"
   LET list[40] = "Cape Verde"
   LET list[41] = "Cayman Islands"
   LET list[42] = "Central African Republic"
   LET list[43] = "Chad"
   LET list[44] = "Chile"
   LET list[45] = "China"
   LET list[46] = "Christmas Island"
   LET list[47] = "Cocos (Keeling) Islands"
   LET list[48] = "Colombia"
   LET list[49] = "Comoros"
   LET list[50] = "Congo"
   LET list[51] = "Congo, the Democratic Republic of the"
   LET list[52] = "Cook Islands"
   LET list[53] = "Costa Rica"
   LET list[54] = "Cote D'Ivoire"
   LET list[55] = "Croatia"
   LET list[56] = "Cuba"
   LET list[57] = "Cyprus"
   LET list[58] = "Czech Republic"
   LET list[59] = "Denmark"
   LET list[60] = "Djibouti"
   LET list[61] = "Dominica"
   LET list[62] = "Dominican Republic"
   LET list[63] = "Ecuador"
   LET list[64] = "Egypt"
   LET list[65] = "El Salvador"
   LET list[66] = "Equatorial Guinea"
   LET list[67] = "Eritrea"
   LET list[68] = "Estonia"
   LET list[69] = "Ethiopia"
   LET list[70] = "Falkland Islands"
   LET list[71] = "Faroe Islands"
   LET list[72] = "Fiji"
   LET list[73] = "Finland"
   LET list[74] = "France"
   LET list[75] = "French Guiana"
   LET list[76] = "French Polynesia"
   LET list[77] = "French Southern Territories"
   LET list[78] = "Gabon"
   LET list[79] = "Gambia"
   LET list[80] = "Georgia"
   LET list[81] = "Germany"
   LET list[82] = "Ghana"
   LET list[83] = "Gibraltar"
   LET list[84] = "Greece"
   LET list[85] = "Greenland"
   LET list[86] = "Grenada"
   LET list[87] = "Guadeloupe"
   LET list[88] = "Guam"
   LET list[89] = "Guatemala"
   LET list[90] = "Guernsey"
   LET list[91] = "Guinea"
   LET list[92] = "Guinea-Bissau"
   LET list[93] = "Guyana"
   LET list[94] = "Haiti"
   LET list[95] = "Heard Island and Mcdonald Islands"
   LET list[96] = "Holy See (Vatican City State)"
   LET list[97] = "Honduras"
   LET list[98] = "Hong Kong"
   LET list[99] = "Hungary"
   LET list[100] = "Iceland"
   LET list[101] = "India"
   LET list[102] = "Indonesia"
   LET list[103] = "Iran, Islamic Republic of"
   LET list[104] = "Iraq"
   LET list[105] = "Ireland"
   LET list[106] = "Isle of Man"
   LET list[107] = "Israel"
   LET list[108] = "Italy"
   LET list[109] = "Jamaica"
   LET list[110] = "Japan"
   LET list[111] = "Jersey"
   LET list[112] = "Jordan"
   LET list[113] = "Kazakhstan"
   LET list[114] = "Kenya"
   LET list[115] = "Kiribati"
   LET list[116] = "Korea, Democratic People's Republic of"
   LET list[117] = "Korea, Republic of"
   LET list[118] = "Kuwait"
   LET list[119] = "Kyrgyzstan"
   LET list[120] = "Lao people's Democratic Republic"
   LET list[121] = "Latvia"
   LET list[122] = "Lebanon"
   LET list[123] = "Lesotho"
   LET list[124] = "Liberia"
   LET list[125] = "Libyan Arab Jamahiriya"
   LET list[126] = "Liechtenstein"
   LET list[127] = "Lithuania"
   LET list[128] = "Luxembourg"
   LET list[129] = "Macao"
   LET list[130] = "Macedonia, the Former Yugoslav Republic of"
   LET list[131] = "Madagascar"
   LET list[132] = "Malawi"
   LET list[133] = "Malaysia"
   LET list[134] = "Maldives"
   LET list[135] = "Mali"
   LET list[136] = "Malta"
   LET list[137] = "Marshall Islands"
   LET list[138] = "Martinique"
   LET list[139] = "Mauritania"
   LET list[140] = "Mauritius"
   LET list[141] = "Mayotte"
   LET list[142] = "Mexico"
   LET list[143] = "Micronesia, Federated States of"
   LET list[144] = "Moldova"
   LET list[145] = "Monaco"
   LET list[146] = "Mongolia"
   LET list[147] = "Montenegro"
   LET list[148] = "Montserrat"
   LET list[149] = "Morocco"
   LET list[150] = "Mozambique"
   LET list[151] = "Myanmar"
   LET list[152] = "Namibia"
   LET list[153] = "Nauru"
   LET list[154] = "Nepal"
   LET list[155] = "Netherlands"
   LET list[156] = "Netherlands Antilles"
   LET list[157] = "New Caledonia"
   LET list[158] = "New Zealand"
   LET list[159] = "Nicaragua"
   LET list[160] = "Niger"
   LET list[161] = "Nigeria"
   LET list[162] = "Niue"
   LET list[163] = "Norfolk Island"
   LET list[164] = "Northern Mariana Islands"
   LET list[165] = "Norway"
   LET list[166] = "Oman"
   LET list[167] = "Pakistan"
   LET list[168] = "Palau"
   LET list[169] = "Palestinian Territory, Occupied"
   LET list[170] = "Panama"
   LET list[171] = "Papua New Guinea"
   LET list[172] = "Paraguay"
   LET list[173] = "Peru"
   LET list[174] = "Philippines"
   LET list[175] = "Pitcairn"
   LET list[176] = "Poland"
   LET list[177] = "Portugal"
   LET list[178] = "Puerto Rico"
   LET list[179] = "Qatar"
   LET list[180] = "Reunion"
   LET list[181] = "Romania"
   LET list[182] = "Russian Federation"
   LET list[183] = "Rwanda"
   LET list[184] = "Saint Barthelemy"
   LET list[185] = "Saint Helena"
   LET list[186] = "Saint Kitts and Nevis"
   LET list[187] = "Saint Lucia"
   LET list[188] = "Saint Martin"
   LET list[189] = "Saint Pierre and Miquelon"
   LET list[190] = "Saint Vincent and the Grenadines"
   LET list[191] = "Samoa"
   LET list[192] = "San Marino"
   LET list[193] = "Sao Tome and Principe"
   LET list[194] = "Saudi Arabia"
   LET list[195] = "Senegal"
   LET list[196] = "Serbia"
   LET list[197] = "Seychelles"
   LET list[198] = "Sierra Leone"
   LET list[199] = "Singapore"
   LET list[200] = "Slovakia"
   LET list[201] = "Slovenia"
   LET list[202] = "Solomon Islands"
   LET list[203] = "Somalia"
   LET list[204] = "South Africa"
   LET list[205] = "South Georgia and the South Sandwich Islands"
   LET list[206] = "Spain"
   LET list[207] = "Sri Lanka"
   LET list[208] = "Sudan"
   LET list[209] = "Suriname"
   LET list[210] = "Svalbard and Jan Mayen"
   LET list[211] = "Swaziland"
   LET list[212] = "Sweden"
   LET list[213] = "Switzerland"
   LET list[214] = "Syrian Arab Republic"
   LET list[215] = "Taiwan, Province of China"
   LET list[216] = "Tajikistan"
   LET list[217] = "Tanzania, United Republic of"
   LET list[218] = "Thailand"
   LET list[219] = "Timor-leste"
   LET list[220] = "Togo"
   LET list[221] = "Tokelau"
   LET list[222] = "Tonga"
   LET list[223] = "Trinidad and Tobago"
   LET list[224] = "Tunisia"
   LET list[225] = "Turkey"
   LET list[226] = "Turkmenistan"
   LET list[227] = "Turks and Caicos Islands"
   LET list[228] = "Tuvalu"
   LET list[229] = "Uganda"
   LET list[230] = "Ukraine"
   LET list[231] = "United Arab Emirates"
   LET list[232] = "United Kingdom"
   LET list[233] = "United States"
   LET list[234] = "United States Minor Outlying Islands"
   LET list[235] = "Uruguay"
   LET list[236] = "Uzbekistan"
   LET list[237] = "Vanuatu"
   LET list[238] = "Vatican City State"
   LET list[239] = "Venezuela"
   LET list[240] = "Viet Nam"
   LET list[241] = "Virgin Islands, British"
   LET list[242] = "Virgin Islands, U.S."
   LET list[243] = "Wallis and Futuna"
   LET list[244] = "Western Sahara"
   LET list[245] = "Yemen"
   LET list[246] = "Zambia"
   LET list[247] = "Zimbabwe"

   -- test for trailing space not to be clipped
   -- if enter NEW should see this entry, when type NEW<space> this should disapppear
   -- LET list[248] = "NEWFOUNDLAND"
END FUNCTION